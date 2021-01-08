ibrary(dplyr)
library(ggplot2)

iris.small<-filter(iris,Species%in%c("virginica","versicolor"))

#logistic regression

glm.out<-glm(Species ~Sepal.Width + Sepal.Length + Petal.Width+Petal.Length,data=iris.small,
             family=binomial)
summary(glm.out)

glm(formula =Species ~Sepal.Width +Sepal.Length +Petal.Width +Petal.Length,family=binomial, data=iris.small)

#we remove sepal length as it has the highest p value

glm.out<-glm(Species ~ Sepal.Width +Petal.Width+Petal.Length,data=iris.small,family=binomial)

summary(glm.out)

#make a plot of fitted probaility as a function of

lr_data <- data.frame(predictor=glm.out$linear.predictors,prob=glm.out$fitted.values,Species=iris.small$Species)
ggplot(lr_data, aes(x=predictor,y=prob,color=Species))+geom_point()


#make a density plot

ggplot(lr_data,aes(x=predictor,fill=Species))+geom_density(alpha=5)


plant1<-data.frame(Sepal.Length=6.4,Sepal.Width=2.8,Petal.Length=4.6,Petal.Width=1.8)
plant2<-data.frame(Sepal.Length=6.3,Sepal.Width=2.5, Petal.Length=4.1,Petal.Width=1.7)
plant3<-data.frame(Sepal.Length=6.7,Sepal.Width=3.3, Petal.Length=5.2,Petal.Width=2.3)

predict(glm.out,plant1,type="response")

predict(glm.out,plant2,type="response")

predict(glm.out,plant3,type="response")
