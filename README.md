# Arctic-Cloud-Detection

This project provides the classification analysis of the cloud data, which is collected from three satellites. 
	Data: a zip archive with three files: image1.txt, image2.txt, image3.txt. Each contains 11 	columns: 
	⁃	y coordinate
	⁃	x coordinate 
	⁃	expert label (+1 = cloud, -1 = not cloud, 0 = unlabeled)
	Features computed based on subject matter knowledge:
	⁃	4. NDAI
	⁃	5. SD
	⁃	6. CORR
	Radiance angles: (Raw features) 
	⁃	7. DF
	⁃	8. CF
	⁃	9. BF
	⁃	10. AF
	⁃	11. AN
Sections of the project: 
	1.	This section includes the summary of the research paper including the motivation and methods. There are several figures and plots created with the purpose to explore the data. 
	2.	This section is the preparation step before we train the model. This includes splitting data, accuracy of a trivial classifier (baseline) and first order importance analysis. Additionally, we wrote a generic cross validation (CV) function CVgeneric in R that takes a generic classifier, training features, training labels, number of folds K and a loss function (at least classification accuracy should be there) as inputs and outputs the K-fold CV loss on the training set. 
	3.	This section we fitted different classification models including logistic, probit, LDA, QDA, and plotROC curves
	4.	This section is Diagnostics section, where we did Kappa statistics to evaluate the models. For more information about this: **Cohen's Kappa statistic** was found from a textbook titled, *Machine Learning with R*- Second Edition by Brett Lantz.
