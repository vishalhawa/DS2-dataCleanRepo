
featureList = read.table("UCIDataset/features.txt")
colnames(featureList) <- c("ID","Signals")
featureList$ID<-NULL 

activityLabel = read.table("UCIDataset/activity_labels.txt")
  colnames(activityLabel) <- c("ID","Label")

# ------TEST DATA - -----------
yTest = read.table("UCIDataset/test/y_test.txt")
subTest = read.table("UCIDataset/test/subject_test.txt")
subActivity = cbind(subTest,yTest)
colnames(subActivity) <- c("Subject","ID")
subActivity = merge(subActivity,activityLabel,by.x="ID",by.y="ID")
tail(subActivity)

xTest = read.table("UCIDataset/test/x_test.txt")
colnames(xTest) <- featureList$Signals
testData = cbind(subActivity,xTest)
testData = testData[,-c(1)]
names(testData)

# ------TRAIN DATA - -----------
yTrain = read.table("UCIDataset/train/y_train.txt")
subTrain = read.table("UCIDataset/train/subject_train.txt")
subActivityTr = cbind(subTrain,yTrain)
colnames(subActivityTr) <- c("Subject","ID")
subActivityTr = merge(subActivityTr,activityLabel,by.x="ID",by.y="ID")
tail(subActivityTr)

xTrain = read.table("UCIDataset/train/x_train.txt")
colnames(xTrain) <- featureList$Signals
trainData = cbind(subActivityTr,xTrain)
trainData = trainData[,-c(1)]
names(trainData)


# --- 
tidyData = rbind(trainData,testData)

tolower(names(tidyData))

# ----------------extraction ---------------------

tidyNamesStd <- grep("std\\(\\)",names(tidyData),value=TRUE)
tidyNamesMean <- grep("mean\\(\\)",names(tidyData),value=TRUE)

tidyDataMeanStd = subset(tidyData, select= c(tidyNamesStd,tidyNamesMean,"Subject","Label"))

tail(tidyDataMeanStd[order(tidyDataMeanStd$Subject),])

#-------------Tidy2--------------------------

tidy2<- tidyDataMeanStd

table(tidy2$Subject,tidy2$Label)



aggdata <-aggregate(tidy2, by=list( tidy2$Subject,tidy2$Label), 
                    FUN=mean, na.rm=TRUE)

aggdata = subset(aggdata, select=-c(Subject,Label))
colnames(aggdata)[1]<-"Subject"
colnames(aggdata)[2]<-"Label"

write.csv(aggdata,file="tidy2.csv")

names(aggdata)

lst=(strsplit(names(aggdata),"\\-"))

signals = sapply(lst, "[[",  1) 
stats = sapply(lst, "[",  2) 
axis = sapply(lst, "[",  3) 

codebook = data.frame(variables=names(aggdata), description=paste(stats,"of",signals,"feature","at",axis,"axis"))

writeLines(paste("'",names(aggdata),"'", "   This is ",stats,"of",signals,"feature","at",axis,"axis"),con="codebook.md")



# ------------End ------------
#-------------For Reference and assessment ---------

#sdf=split(tidy2,list(tidy2$Subject, tidy2$Label))

# w.m <- lapply(sdf,mean)

# tidyDataStd=subset(tidyData, select= tidyNamesStd)
# tidyDataMean=subset(tidyData, select= tidyNamesMean)
# match<-regexpr("(^[A-z]+)[-]",names(aggdata))

# regmatches(names(aggdata),match) 


