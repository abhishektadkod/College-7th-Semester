library(ggplot2)
library(reshape2)
library(dplyr)
library(caret)

library(MASS)
library(mlbench)


data("Boston")
data("BostonHousing")

boston=Boston
boston=BostonHousing

str(boston)

ggplot(boston, aes(x=medv))+
  stat_density()+
  labs(X="Median Value($1000) House Price in Boston",Y="Density",title="Density Plot of median value House Price in Boston") +
  theme_minimal()

summary(boston$medv)

z=boston %>% select(c(crim,rm,age,rad,tax,lstat,medv)) %>% melt(id.vars="medv")

boston %>% select(c(crim,rm,age,rad,tax,lstat,medv)) %>% melt(id.vars="medv") %>% ggplot(aes(x=value,y=medv,colour=variable))+
  geom_point(alpha=0.7) +
  stat_smooth(aes(colour="black"))+
  facet_wrap(z$variable,scales="free",ncol=2)+
  labs(x="variable value",y="Median House Price($1000)")+
  theme_minimal()

set.seed()
to_train=createDataPartition(y=boston$medv,p=0.75,list=FALSE)
train=boston[to_train,]

to_test=createDataPartition(y=boston$medv,p=0.25,list=FALSE)
test=boston[to_test,]

first_lm=lm(medv~crim+rm+tax+lstat,data=train)
lm1_rsqu=summary(first_lm)$r.squared
print(paste("Our first linear model has r-squared value of: ",round(lm1_rsqu,3),sep=""))

second_lm=lm(log(medv)~crim+rm+tax+lstat,data=train)
lm2_rsqu=summary(second_lm)$r.squared
print(paste("Our second linear model has r-squared value of: ",round(lm2_rsqu,3),sep=""))

abs(mean(second_lm$residuals))

predicted=predict(second_lm,newdata = test)

results=data.frame(predicted=exp(predicted),original=test$medv)

results %>% ggplot(aes(x=predicted,y=original))+
  geom_point()+
  stat_smooth()+
  labs(x="Predicted values",y="original values",title="Predicted v/s Original values")+
  theme_minimal()
