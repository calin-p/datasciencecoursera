##Read Me

This script (labeled "run_analysis.R") calculates the average values for all the values (train and test) that contains mean and standard deviation values of the measurements from accelerometers and gyroscopes used in the Human Activity Recognition experiment ran at Universitat Politècnica de Catalunya and Università degli Studi di Genova [1].

The script does not change any measurements units or normalization factors from the initial data set.

###Data set structure
The used dataset has the following structure:

* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Feature description
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autoregression coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean


###Script structure and functionality

Each file from the two sub-sets, test and train, is read into a corresponding data frame (e.g. "X_test" data frame has the data from "X_test.txt" file). After reading from files amd joining the corresponding data we end up with following data frames:

1. "X_data" resulted from row-binding "X_test" and "X_train"
2. "activity" resulted from row-binding "activity_test" and "activity_train"
3. "subject" resulted from row-binding "subject_test" and "subject_train"

To this data frames we add the "features" vector, where we read all the features list from "features.txt" file.

After reading the data from files we will compose an overall data set (labeled "X_all") by joining together "X_data", "activity" and "subject". We temporary add an additional attribute labeled "index" to all the data sets for the inner join operation. After joining them we labeled the attributes in "X_all"  using the strings from "features" vector plus separate labels for "activity" and "subject". We remove than the "index" attribute from all data sets. If needed, the overall raw data can be saved for other usage.

From the overall data set ("X_all") we keep only the attributes related with mean and standard deviation for each measurement in "X_data_reduced" data frame. We change the type of "subject" attribute from int to factors and read the label for each activity in a vector (labeled "activity_label") from "activity_labels.txt" file. We use this vector to add proper names to the reduced data set.

From the reduced data set we proceeded to calculate the average of each variable for each activity and each subject. Each row contains the mean of the variables calculated over all the records associated wit a specific "activity" for each one of the subjects that ran the experiment.

This data set is the final product and we write it to a file labeled "Clean_data_project.txt" 

###Licence:

This data set is produced by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita in November 2012 as base for the followin publication:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The original data set and its description can be found at the [following link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).