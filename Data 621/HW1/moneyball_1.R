library(ggcorrplot)
library(DT)
library(zoo)
library(dplyr)
library(heatmaply)
library(GGally)

library(Hmisc)

train_df=read.csv("~/GitHub/SPS/Data 621/HW1/moneyball-training-data.csv")
head(train_df)


train_=replace(train_df, TRUE, lapply(train_, na.aggregate))
summary(train_)

corr=round(cor(train_),2)
corr
p.train=cor_pmat(train_)
head(p.train)


ggcorrplot(corr, hc.order = TRUE, lab=TRUE, p.mat =p.train, insig = "blank" )





# Check correlations (as scatterplots), distribution and print corrleation coefficient 
## ggpairs(train_df, title='correlogram with ggpairs') 

ggplot(train_df, aes(x=TARGET_WINS, y=TEAM_PITCHING_SO)) +
  geom_point(size=2)


#train_df$index_cat_so<-cut(train_df$TEAM_PITCHING_SO, c(0,500,750,1000,1250,1500,1800,2000))

#train_df$group <- as.factor(ifelse(train_df$TEAM_BATTING_HBP==59.9), 'A','B')

ggplot(train_df, aes(x=TEAM_PITCHING_SO, y= TARGET_WINS)) + 
  geom_point(size=2)


ggplot(train_df, aes(x=TEAM_PITCHING_H, y= TARGET_WINS, color=index_cat_so)) + 
  geom_point(size=2)


train_df=train_df %>%
  filter(`TEAM_PITCHING_H` < 7054)

train_df

ggplot(train_df, aes(x=TEAM_PITCHING_SO, y= TARGET_WINS)) + 
  geom_point(size=2)

train_df=train_df %>%
  filter(`TEAM_PITCHING_SO` < 2000)
train_df

train_df=train_df %>%
  filter(`TEAM_PITCHING_SO` > 50)
train_df

ggplot(train_df, aes(x=TEAM_PITCHING_SO, y= TARGET_WINS)) + 
  geom_point(size=2)


#train_df=train_df %>%
#  filter(index_cat_so != "<NA>")

train_df



#train_df$group <- as.factor(ifelse(train_df$TEAM_BATTING_HBP==59.9), 'A','B')

ggplot(train_df, aes(x=TEAM_PITCHING_SO, y= TARGET_WINS, color=index_cat_so)) + 
  geom_point(size=2)


describe(train_df$TEAM_PITCHING_H)

quantile(train_df$TEAM_PITCHING_H, probs = c(.25, .5, .99))

#Correlation again
train_df
tail(train_df)
library(imputeTS)
train_df=na_mean(train_df)

tail(train_df)
corr_df=round(cor(train_df),2)
corr_df
p.train_df=cor_pmat(train_df)

ggcorrplot(corr_df, hc.order = TRUE, lab=TRUE,p.mat =p.train_df, insig = "blank" )
describe(train_df)
tail(train_df)

#ggpairs(train_df, title='correlogram with ggpairs') 

model = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
          TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_BATTING_HBP +
          TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E +
            TEAM_FIELDING_DP, data = train_df)
summary(model)


model1 = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + TEAM_BATTING_BB +
             TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + 
             TEAM_PITCHING_SO + TEAM_FIELDING_E , data = train_df)
summary(model1)

model3 = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_3B + TEAM_BATTING_HR + TEAM_BATTING_BB +
              TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + 
              TEAM_PITCHING_SO + TEAM_FIELDING_E , data = train_df)
summary(model3)

model4 = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
             TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_BATTING_HBP +
             TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E +
             TEAM_FIELDING_DP, data = train_)
summary(model4)

model5 = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
              TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_BATTING_HBP +
              TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E +
              TEAM_FIELDING_DP, data = train_)
summary(model5)

model6 = lm(TARGET_WINS ~ TEAM_BATTING_H + TEAM_BATTING_2B + TEAM_BATTING_3B + TEAM_BATTING_HR + 
              TEAM_BATTING_BB + TEAM_BATTING_SO + TEAM_BASERUN_SB + TEAM_BASERUN_CS + TEAM_BATTING_HBP +
              TEAM_PITCHING_H + TEAM_PITCHING_HR + TEAM_PITCHING_BB + TEAM_PITCHING_SO + TEAM_FIELDING_E +
              TEAM_FIELDING_DP, data = train_)
summary(model6)

backward_model=lm(TARGET_WINS ~ ., data = train_)
summary(backward_model)

backward_model= update(backward_model, . ~ . - TEAM_PITCHING_BB)
summary(backward_model)

backward_model= update(backward_model, . ~ . - TEAM_PITCHING_HR)
summary(backward_model)

backward_model= update(backward_model, . ~ . - TEAM_BASERUN_CS)
summary(backward_model)

backward_model= update(backward_model, . ~ . - TEAM_BATTING_HBP)
summary(backward_model)

backward_model= update(backward_model, . ~ . - INDEX)
summary(backward_model)


aic_model=lm(TARGET_WINS ~ ., data = train_)
summary(aic_model)

step(aic_model, direction = "backward")
s