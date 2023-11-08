library(arrow)
library(dplyr)
training_data <- read_parquet("/Users/xiaojunq/Desktop/train_datatrots_2013-2022 (2).parquet")
testing_data <- read_parquet("/Users/xiaojunq/Desktop/test_datatrots_2013-2022 (2).parquet")

train_ID <- training_data$Race_ID
test_ID <- testing_data$Race_ID

X_train = training_data %>% select(-c('Race_ID','RaceStartTime', 'win probability'))
y_train = training_data$`win probability`
X_test = testing_data %>% select(-c('Race_ID','RaceStartTime', 'win probability'))
y_test = testing_data$`win probability`

#variables selection: lasso regression
library(glmnet)
x <- as.matrix(X_train)
fit = glmnet(x, y_train)
plot(fit)
cvfit = cv.glmnet(x, y_train)#choose lambda using cross-validation
coef(fit,s=cvfit$lambda.min)

lasso_yhat = predict(fit, cvfit$lambda.min, newx = as.matrix(X_test))
lasso_mse = mean((y_test - lasso_yhat)^2)
lasso_mse#0.06921359

#linear regression
lm_fit <- lm(y_train~., data = X_train)#full model
lm_yhat <- predict(lm_fit, newx = X_test)
lm_mse = mean((y_test - lm_yhat)^2)
lm_mse#0.09647083

#forward selection
null_model<-lm(y_train~1,data=X_train)
fit.forward<-step(null_model,scope=list(lower=y_train~1, upper=lm_fit),
                  direction='forward')
summary(fit.forward)
lm.forward_yhat <- predict(fit.forward, newx = X_test)
lm.forward_mse = mean((y_test - lm.forward_yhat)^2)#0.09647057

#variables selected by lasso
lm_fit_lasso <- lm(y_train~Barrier+CourseIndicator+Distance+FrontShoes+
                     HandicapDistance+HindShoes+HorseAge+HorseID+JockeyID+
                     RaceID+RacePrizemoney+Saddlecloth+SireID+StartingLine+
                     TrainerID+WeightCarried+WetnessScale+AgeRestriction_3+
                     AgeRestriction_5+AgeRestriction_8+AgeRestriction_9+
                     AgeRestriction_10+Barrier_Flag+NW_Value+CourseIndicator_Flag+
                     DamID_Frequency+Finish_Flag+Non_Finish_Status+FoalingDate_Year+
                     FoalingDate_Month+FoalingDate_Day_of_Week+HandicapType_Cwt+
                     HandicapType_Hcp+Race_G3+RacingSubType_T+StartType_V+
                     `SexRestriction_C&G`+SexRestriction_M+Surface_S+Surface_T+
                     `FoalingCountry_FR `+Gender_F+Gender_M+`GoingAbbrev_SO `+
                     GoingID_9, data = X_train)
lm_fit_lasso_yhat <- predict(lm_fit_lasso, newx = X_test)
lm_mse2 = mean((y_test - lm_fit_lasso_yhat)^2)
lm_mse2#0.09517582

#logistic regression
logit_fit <-  glm(y_train~., family = binomial(link='logit'),
                  data = X_train)#full model

logit.pred_probs <- predict(logit_fit, newdata = X_test, type = "response")
logit_mse = mean((y_test - logit.pred_probs)^2) #0.06799406

#variables selected by lasso
logit_fit_lasso <- glm(y_train~Barrier+CourseIndicator+Distance+FrontShoes+
                     HandicapDistance+HindShoes+HorseAge+HorseID+JockeyID+
                     RaceID+RacePrizemoney+Saddlecloth+SireID+StartingLine+
                     TrainerID+WeightCarried+WetnessScale+AgeRestriction_3+
                     AgeRestriction_5+AgeRestriction_8+AgeRestriction_9+
                     AgeRestriction_10+Barrier_Flag+NW_Value+CourseIndicator_Flag+
                     DamID_Frequency+Finish_Flag+Non_Finish_Status+FoalingDate_Year+
                     FoalingDate_Month+FoalingDate_Day_of_Week+HandicapType_Cwt+
                     HandicapType_Hcp+Race_G3+RacingSubType_T+StartType_V+
                     `SexRestriction_C&G`+SexRestriction_M+Surface_S+Surface_T+
                     `FoalingCountry_FR `+Gender_F+Gender_M+`GoingAbbrev_SO `+
                     GoingID_9, family = binomial(link='logit'), data = X_train)

logit.pred_probs2 <- predict(logit_fit_lasso, newdata = X_test, type = "response")
logit_mse2 = mean((y_test - logit.pred_probs2)^2) #0.07034047