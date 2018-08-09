# Artificial Neural Network

# Importing the dataset
dataset = read.csv('train.csv')
View(dataset)

dataset = dataset[,-2]
dataset= dataset[,-3]
dataset = dataset[,-12]

str(dataset)

str(dataset$area_assesed)
str(dataset$damage_grade)

# Encoding the categorical variables as factors
dataset$area_assesed = as.numeric(factor(dataset$area_assesed,
                                      levels = c('Both', 'Building removed', 'Exterior',
                                                 'Not able to inspect'),
                                      labels = c(1, 2, 3,4)))

dataset$damage_grade = as.numeric(factor(dataset$damage_grade,
                                   levels = c('Grade 1', 'Grade 2', 'Grade 3','Grade 4','Grade 5'),
                                   labels = c(1, 2,3,4,5 )))

# # Splitting the dataset into the Training set and Test set
# # install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Exited, SplitRatio = 0.8)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# # Feature Scaling
# training_set[-11] = scale(training_set[-11])
# test_set[-11] = scale(test_set[-11])

# Fitting ANN to the Training set
# install.packages('h2o')
library(h2o)
h2o.init(nthreads = -1)
model = h2o.deeplearning(y = 'damage_grade',
                         training_frame = as.h2o(dataset),
                         activation = 'Rectifier',
                         hidden = c(6,6),
                         epochs = 100,
                         train_samples_per_iteration = -2)


#reading the test file
testdata = read.csv("test.csv")
head(testdata)

testdata$area_assesed = as.numeric(factor(testdata$area_assesed,
                                         levels = c('Both', 'Building removed', 'Exterior',
                                                    'Not able to inspect'),
                                         labels = c(1, 2, 3,4)))

str(testdata)

# Predicting the Test set results
y_pred = h2o.predict(model, newdata = as.h2o(testdata))
y_pred = round(y_pred, digits = 0)
head(y_pred)

y_pred= if(y_pred == 1)
        print('Grade 1')

 levels = c('1','2','3','4','5'),
                            labels = c('Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5'))
###smape function performance
smape_cal <- function(train, y_pred){
  smape <- (abs(train-y_pred)/(abs(train)+abs(y_pred)))
  return(smape)}




setwd("C:/Users/new/Desktop/ML/ML hackerank/dataset")
write.csv(y_pred, file = "test.csv", row.names = F)



# h2o.shutdown()