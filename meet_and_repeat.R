

#Loading the data sets (wide form):

BPRS2 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)
RATS2 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep ="", header = T)

#Checking the structure of the data:

str(BPRS2)
str(RATS2)

#Writing the data sets to files:

write.table(BPRS2, "data/BPRS2", sep = " ")
write.table(RATS2, "data/RATS2", sep = " ")


#These data are in the wide form, i.e. the unit of analysis is one participant, and each time point (week) is stored in its own column.

#The variables in the data sets are:

#BPRS2: treatment (psychiatric treatment group, 1 or 2), subject (subject ID number; each subject was treated with both treatment 1 and treatment 2),
#week represents the time point in which each subject was measured; "each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals for eight weeks.
#The BPRS assesses the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and grandiosity; each of these is rated from one (not present) to seven (extremely severe). The scale is used to evaluate patients suspected of having schizophrenia."

#RATS2: subject (rat) ID, Group (diet 1, 2, or 3), WD represents the animal's body weight at different time points (days since the beginning of the study).


#In order to conduct our analyses of choice, we need to restructure the data sets to long form, i.e. so that in BPRS, each week is collapsed as one value of a single variable ("week"), and in RATS, each weight measurement is gathered under the same variable ("weight").


#TASK 2: Converting the categorical variables of both data sets to factors:

library(dplyr)
library(tidyr)

#Factoring the variables:
BPRS2$treatment <- factor(BPRS2$treatment)
BPRS2$subject <- factor(BPRS2$subject)

RATS2$ID <- factor(RATS2$ID)
RATS2$Group <- factor(RATS2$Group)

#TASK 3: Converting both data sets to long form:

BPRS2_long <- BPRS2 %>% gather(key = weeks, value = BPRS, -treatment, -subject)  #conversion to long form
BPRS2_long <- BPRS2_long %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRS2_long)

RATS2_long <- RATS2 %>% gather(key = days, value = grams, -ID, -Group)
RATS2_long <- RATS2_long %>% mutate(day = as.integer(substr(days,3,4)))


write.table(BPRS2_long, "data/BPRS2_long", sep = " ")
write.table(RATS2_long, "data/RATS2_long", sep = " ")


#TASK 4: Taking a look at the new data sets

#Now the file "BPRS2_long" has the data in the long form: each measurement point (week) has been gathered under one variable. 
#(And placed within each week we have each participant having both treatment 1 and 2 = crossover design).

#Similarly, the file "RATS2_long" now has each measurement point (day) gathered under one variable.
#(In this setting, each rat only belonged to one diet group.)

#In short, we are now able to examine the within-subject variation over time - while also taking into account the experimental design of the study (study group), i.e. between-subject variation.