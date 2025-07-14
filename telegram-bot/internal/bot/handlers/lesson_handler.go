package handlers

import (
	"context"

	"go.uber.org/zap"
	tele "gopkg.in/telebot.v3"

	"telegram-bot/internal/bot/fsm"
)

// HandleLearnCommand handles the /learn command with new learning flow
func (s *HandlerService) HandleLearnCommand(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	// Check if the user has completed the onboarding process
	userProgress, err := s.GetUserProgress(ctx, userID)
	if err != nil {
		s.logger.Error("Failed to get user progress", zap.Error(err))
		return err
	}

	// If user hasn't completed onboarding, prompt them to start
	if userProgress.CEFRLevel == "" {
		startButton := &tele.InlineButton{
			Text: "Начать настройку",
			Data: "onboarding:start",
		}
		keyboard := &tele.ReplyMarkup{
			InlineKeyboard: [][]tele.InlineButton{
				{*startButton},
			},
		}

		return c.Send("Похоже, вы еще не завершили первоначальную настройку. "+
			"Давайте сначала определим ваш уровень английского.", keyboard)
	}

	// Start new learning flow
	return s.HandleNewLearningStart(ctx, c, userID, currentState)
}

// HandleTestCommand handles the /test command
func (s *HandlerService) HandleTestCommand(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	// Set user state to vocabulary test
	if err := s.stateManager.SetState(ctx, userID, fsm.StateVocabularyTest); err != nil {
		s.logger.Error("Failed to set vocabulary test state", zap.Error(err))
		return err
	}

	// Send test introduction message
	testText := "🧠 *Тест уровня CEFR*\n\n" +
		"Этот тест поможет определить ваш уровень владения английским языком согласно шкале CEFR.\n\n" +
		"Вы увидите серию слов. Для каждого слова укажите, хорошо ли вы его знаете.\n\n" +
		"Тест состоит из 5 частей и займет около 5-10 минут. Готовы начать?"

	// Create test keyboard
	keyboard := &tele.ReplyMarkup{
		InlineKeyboard: [][]tele.InlineButton{
			{
				{Text: "Начать тест", Data: "test:start"},
				{Text: "Позже", Data: "menu:main"},
			},
		},
	}

	return c.Send(testText, &tele.SendOptions{ParseMode: tele.ModeMarkdown}, keyboard)
}

// HandleLessonStartCallback handles lesson start callback
func (s *HandlerService) HandleLessonStartCallback(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	return c.Send("Начинаем урок...")
}

// HandleLessonLaterCallback handles lesson later callback
func (s *HandlerService) HandleLessonLaterCallback(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	return c.Send("Урок отложен.")
}

// HandleTestSkipCallback handles test skip callback
func (s *HandlerService) HandleTestSkipCallback(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	// Set user to start state (onboarding complete)
	if err := s.stateManager.SetState(ctx, userID, fsm.StateStart); err != nil {
		s.logger.Error("Failed to set start state", zap.Error(err))
		return err
	}

	// Send completion message
	completionText := "🎉 *Добро пожаловать в Fluently!*\n\n" +
		"Настройка завершена! Теперь ты можешь начать изучение.\n\n" +
		"Используй /learn чтобы начать свой первый урок!"

	// Create main menu keyboard
	keyboard := &tele.ReplyMarkup{
		InlineKeyboard: [][]tele.InlineButton{
			{{Text: "Начать изучение", Data: "lesson:start"}},
			{{Text: "Настройки", Data: "menu:settings"}},
		},
	}

	return c.Send(completionText, &tele.SendOptions{ParseMode: tele.ModeMarkdown}, keyboard)
}

// HandleWaitingForTranslationMessage handles translation waiting state
func (s *HandlerService) HandleWaitingForTranslationMessage(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	return c.Send("Пожалуйста, предоставьте перевод.")
}

// HandleWaitingForAudioMessage handles audio waiting state
func (s *HandlerService) HandleWaitingForAudioMessage(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	return c.Send("Пожалуйста, предоставьте аудио ответ.")
}

// HandleAudioExerciseResponse handles audio exercise responses
func (s *HandlerService) HandleAudioExerciseResponse(ctx context.Context, c tele.Context, userID int64, voice interface{}) error {
	return c.Send("Получен ответ на аудио упражнение.")
}

// HandleLearnMenuCallback handles learn menu callback
func (s *HandlerService) HandleLearnMenuCallback(ctx context.Context, c tele.Context, userID int64, currentState fsm.UserState) error {
	return c.Send("Меню обучения...")
}
