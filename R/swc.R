
#software carpentry intermed session on R 
#Jan 5, 2015
#using assignment operators
#use the arrow #= is for assigning values within functions
x<-5

surveys<- read.csv(file="surveys.csv")

#additional search option if you don't know which function you need:
#help.search("name of something")

#ERRORS:  copy error text and search online

#inflammation dataset -- calculate avg across all and plot

inf02<- read.csv(file="inflammation-02.csv", header=FALSE)

#chek how it is stored adn teh shape
class(inf02)
dim(inf02)  #yields #ROWS #COLUMNS

#look up a partic line
inf02[30, 2] #patient 30 on day 2
inf02[31, 2] #patient 31 on day 2
#all values for day 2
inf02[,2]
#patients 1-4 on days 1-5
inf02[1:4, 1:5]
#mean for all patients on day 7
mean(inf02[,7])
#min, median, sd

#ROWS=MARGIN 1, COLUMNS= MARGIN 2
#apply
#section of a dataframe is a slice

#avg inflamation for all patients on each day: 
apply(inf02, MARGIN=2, mean) #margin 2 is to calculate for each column
#to make it apply to a subset, you'd add [1:5,] etc.
#do it again but asign it to an object so that you can plot it.
avg_day_inf<-apply(inf02, MARGIN=2, mean)
plot(avg_day_inf)
max_day_inf<-apply(inf02, MARGIN=2, max)
plot(max_day_inf)
min_day_inf<-apply(inf02, MARGIN=2, min)
plot(min_day_inf)
sd_day_inf<-apply(inf02, MARGIN=2, sd)
plot(sd_day_inf)

#define a function that takes args.

#convert F to K
fahr_to_kelv<- function(temp){
  kelvin<-((temp-32)*(5/9))+273.15
  return(kelvin) #don't have to specify a return value, but it is a good practice to specify
}
fahr_to_kelv(7)
#function to convert K to C

#if you define a var within a function it only exists within that function
#don't end up with a lot of objects within the workspace
kelv_to_c<- function(tempK){
  celcius<-tempK-273.15
  return(celcius)
}

#combine the functions to calc C

fahr_to_C<- function(temp){
  tempK<-fahr_to_kelv(temp) 
  result<-kelv_to_c(tempK)
  return(result)
}
fahr_to_C(32)

#make a vector
best_practice<- c("Write", "programs", "for", "people", "not", "computers")
best_practice
asterisk<-"***"
#create a function called fence that places the asterisks at either end 
#of the vector
#two
new<- c(best_practice, asterisk)
fence<- function(original, wrapper){#put both args in after the function
  final<-c(wrapper, original, wrapper)#you can specify what you want to pu tinto it when you call the function
  return(final)
} 

fence(best_practice, asterisk)
star<-"*"
fence(best_practice, star)

#function called analyze that will allow you to create all of 
#those plots for each data file adn output it into a plot

analyze<- function(filename){
  data<- read.csv(file=(filename), header=FALSE)
  mean_inf<-apply(data, MARGIN=2, mean)
  plot(mean_inf)
}

analyze("inflammation-02.csv")

#but you still have to enter/call each data file separately, 
#which would be time consuming if had a lot of data files, so
#to streamline it create a for() loop
#the general structure is:
for(variable in collection){
  Do things
}

#to cal the # in a vector:
length(best_practice)
#but if wanted to create a function to do it:
len<-0# set a counter to zero
for (v in best_practice){#within the for loop, for each element in vector 
  len<-len+1
}
len

#function to cal total of values in vector
values<- c(1,2,3)
sum<- function(vec){
  total=0
  for (v in vec){#v could be anything, it just is a standin for an element of the vector
    total=total+v
  }
  return(total)
}
sum(values)
#can create a new vetor to test it
vec2<-c(2,3,4)
> sum(vec2)



#creating a loop to batch analyze inflam data

#to bring all names into R environment
list.files(pattern="csv")
#further refining
#list.files(pattern="^inflammation.+\\.csv$") 
#the ^ means that inflamm is at the beginning of the string
#output looks like a vector, so you can assign it to an object to use later
filenames<- list.files(pattern="inflammation") 
#then create the loop to analyze/plot
for (f in filenames){
  print (f)
  analyze (f)
}

#createa  funct analyze.all that takes the filename pattern that you are looking for

analyze.all<- function (datapattern){
  filenames<- list.files(pattern=datapattern) 
  for (f in filenames){
    print (f)
    analyze (f)
  }
}
analyze.all("inflam")

#see course notes online for info on creating conditional statements
#could load datafile to github and have script pull the datafile from github
#

adding something on the end to change it.