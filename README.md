# French_Trot_2023
[website link](https://canssiontario.utoronto.ca/workshops-conferences/french-trot-horse-racing/)

## Group Member
- Xiao Jun Qiu
- Tao Shan
- E Ching Kho

## Preprocessing (Tao_Data_Preprocessing.ipynb)
We filled in missing values and convert category variables to dummy variables or convert to other compesite variables that make more sense.

The following are list of variables we have modified:
- AgeRestriction
- Barrier
- ClassRestriction
- CourseIndicator
- DamID
- FoalingDate
- HandicapType
- RaceGroup
- RaceStartTime
- RacingSubType
- SexRestriction
- StartType
- Surface

Then we perform a scaling for variable with ID

At last, we split the data into training and testing data based on the mentioned datae 2021-11-01.

### Win Probability
For the true label of win proability, we decide to use the percentage of prizemoney. In that case, we assure the true win proability of each raceID sums to 1.

## Model Training
The following are a list of models we tried:
- decision tree
- random forest
- gradientboosttree
- xgboost
- linear regression
- logistic regression
- lasso regression

## Result
After comparing results, we decide to submit our xgboost model as it has the best performance among all models.