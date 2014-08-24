# Column Header Names and Description
## Intro
This data set contains data taken from a smarthphone from 30 subjects where their acitivty was recorded as well as processed reading from their smartphone's accelerometer and gyroscope. We report the average mean and standard devitation data values for the for each subject and activity combination.
## Data Label Name Explanation
The time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc.XYZ and tGravityAcc.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk.XYZ and tBodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc.XYZ, fBodyAccJerk.XYZ, fBodyGyro.XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency (Fourier) domain signals). These signals were used to estimate variables of the feature vector for each pattern: '.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
## Column Names
The folllowing are the column names used in tidy_data_set.txt file and are also found in the header.
1. tBodyAcc.mean.X
2. tBodyAcc.mean.Y
3. tBodyAcc.mean.Z
4.tBodyAcc.std.X
5. tBodyAcc.std.Y
6. tBodyAcc.std.Z
7. tGravityAcc.mean.X
8. tGravityAcc.mean.Y
9. tGravityAcc.mean.Z
10. tGravityAcc.std.X
11. tGravityAcc.std.Y
12. tGravityAcc.std.Z
13. tBodyAccJerk.mean.X
14. tBodyAccJerk.mean.Y
15. tBodyAccJerk.mean.Z
16. tBodyAccJerk.std.X
17. tBodyAccJerk.std.Y
18. tBodyAccJerk.std.Z
19. tBodyGyro.mean.X
20. tBodyGyro.mean.Y
21. tBodyGyro.mean.Z
22. tBodyGyro.std.X
23. tBodyGyro.std.Y
24. tBodyGyro.std.Z
25. tBodyGyroJerk.mean.X
26. tBodyGyroJerk.mean.Y
27. tBodyGyroJerk.mean.Z
28. tBodyGyroJerk.std.X
29. tBodyGyroJerk.std.Y
30. tBodyGyroJerk.std.Z
31. tBodyAccMag.mean
32. tBodyAccMag.std
33. tGravityAccMag.mean
34. tGravityAccMag.std
35. tBodyAccJerkMag.mean
36. tBodyAccJerkMag.std
37. tBodyGyroMag.mean
38. tBodyGyroMag.std
39. tBodyGyroJerkMag.mean
40. tBodyGyroJerkMag.std
41. fBodyAcc.mean.X
42. fBodyAcc.mean.Y
43. fBodyAcc.mean.Z
44. fBodyAcc.std.X
45. fBodyAcc.std.Y
46. fBodyAcc.std.Z
47. fBodyAccJerk.mean.X
48. fBodyAccJerk.mean.Y
49. fBodyAccJerk.mean.Z
50. fBodyAccJerk.std.X
51. fBodyAccJerk.std.Y
52. fBodyAccJerk.std.Z
53. fBodyGyro.mean.X
54. fBodyGyro.mean.Y
55. fBodyGyro.mean.Z
56. fBodyGyro.std.X
57. fBodyGyro.std.Y
58. fBodyGyro.std.Z
59. fBodyAccMag.mean
60. fBodyAccMag.std
61. fBodyBodyAccJerkMag.mean
62. fBodyBodyAccJerkMag.std
63. fBodyBodyGyroMag.mean
64. fBodyBodyGyroMag.std
65. fBodyBodyGyroJerkMag.mean
66. fBodyBodyGyroJerkMag.std
67. subject.id
68. activity