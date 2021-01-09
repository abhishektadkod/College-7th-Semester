#install.packages("tm")        #textmining
#install.packages("wordcloud")
#install.packages("e1071")

library(tm)
library(wordcloud)
library(e1071)

sms_spam_df <- read.csv(file="C:\\Users\\USER\\Desktop\\College-7th-Semester\\Labs\\DS\\sms_spam.csv",stringsAsFactors = F)
str(sms_spam_df)

#head(sms_spam_df) head displays first 5 rows
#table(sms_spam_df$category) total count of 2 variables

#Data Preparation - cleaning and standardizing text data

#creating a corpus(collection of documents)
sms_corpus <- VCorpus(VectorSource(sms_spam_df$text))  
print(sms_corpus)

#view a summary of the first and second sms msgs in the corpus
#inspect(sms_corpus[1:2])

#data pre-processing
clean_corpus <- tm_map(sms_corpus,content_transformer(tolower))
#as.character(clean_corpus[[1]])

#remove numbers
clean_corpus <- tm_map(clean_corpus,removeNumbers)
clean_corpus <- tm_map(clean_corpus,removePunctuation)

#remove stopwords
#stopwords()[1:15]
clean_corpus <- tm_map(clean_corpus,removeWords,stopwords())

#remove whitespaces
clean_corpus <- tm_map(clean_corpus,stripWhitespace)

#display detailed information
inspect(clean_corpus[1:3])

#tokenize each msg into words to build key structure
sms_dtm <- DocumentTermMatrix(clean_corpus)  
str(sms_dtm)

#the which() function will return the position of elements
spam_indices <- which(sms_spam_df$category == "spam")
ham_indices <- which(sms_spam_df$category == "ham")

#spam_indices
#ham_indices

wordcloud(clean_corpus[ham_indices],min.freq = 40) # look at most 40 common words
wordcloud(clean_corpus[spam_indices],min.freq = 40)

#split out training and test cases
#split raw data
sms_raw_train <- sms_spam_df[1:4169,]
sms_raw_test <- sms_spam_df[4170:5559,]

#split document term matrix
sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]

#split corpus
sms_corpus_train <- clean_corpus[1:4169]
sms_corpus_test <- clean_corpus[4170:5559]

#create separate corpuses for spam and ham

spam <- subset(sms_raw_train,category=="spam")
ham <-  subset(sms_raw_train,category=="ham")

#reducing DTM
five_times_words <- findFreqTerms(sms_dtm_train,5)  #word should appear in atleast 5 msg

sms_train <- DocumentTermMatrix(sms_corpus_train,control = list(dictionary=five_times_words))
sms_test <- DocumentTermMatrix(sms_corpus_test,control = list(dictionary=five_times_words))

convert_count <- function(x){
  y <- ifelse(x > 0,1,0)
  y <- factor(y,levels=c(0,1),labels=c("No","Yes"))
  y
}

sms_train <- apply(sms_train,2,convert_count)
sms_test <- apply(sms_test,2,convert_count)

sms_classifier <- naiveBayes(sms_train,factor(sms_raw_train$category))
sms_test_pred <- predict(sms_classifier,newdata=sms_test)
k=table(sms_test_pred,sms_raw_test$category)
k
accuracy = sum(diag(k))/sum(k)*100
accuracy
