# CANSSI Competition French Trot Horse Racing 2023
For an in-depth introduction of the French Trot Horse Racing Competition, please refer to [this website](https://canssiontario.utoronto.ca/workshops-conferences/french-trot-horse-racing/)

## Collaborative Team
Our study was conducted by a dedicated team comprising:
- Xiao Jun Qiu
- Tao Shan
- E Ching Kho

## Data Preparation (Tao_Data_Preprocessing.ipynb)
Our initial step in the analytical process involved a comprehensive data cleansing routine. We meticulously addressed missing entries and transformed categorical variables into dummy indicators, enhancing their interpretability. Additionally, we refined several variables to construct more meaningful composite measures. 

The variables refined include:
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

Subsequently, we normalized the variables associated with identification to ensure uniformity in scale. 

Finally, we partitioned our dataset into training and testing subsets, employing a cutoff date of November 1, 2021 as required.

### Constructing the Win Probability Metric
In quantifying the likelihood of winning, we adopted the distribution of prize money as a proxy for the true win probability. This innovative approach guarantees that the aggregated probability for each raceID is sum to 1.

We devised a custom normalization function that adeptly adjusts the predicted win probabilities for the trained model, ensuring their collective sum per raceID achieves the desired total of 1.

## Training of Predictive Models
Throughout our investigation, we experimented with an array of predictive models to ascertain the most effective algorithm, including:
- Decision Tree
- Random Forest
- Gradient Boosting Tree
- XGBoost
- Linear Regression
- Logistic Regression
- Lasso Regression

## Conclusive Findings
Upon meticulous evaluation, we concluded that the XGBoost model exhibited superior performance relative to its counterparts. Consequently, we have nominated this model for our official submission, given its exceptional predictive prowess.