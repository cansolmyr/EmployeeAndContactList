# EmployeeAndContactList
Tallinn - Tartu Employee List

**1. What are the requirements to compile and run program**
  1.1 XCode 12.2 and above
  1.2 iOS 14 (Emulator or device)



**2. What architecture pattern did you use (including reference) and why**
  I prefer VIPER because the roles of classes are more clear in VIPER design. Developers have to divide Entity and Presenter. Segregating responsibilities makes it more clear than MVVM and MVP. 
  
  View Controller classes are clean. Responsibility Segregation for layers. Reusability
  
  
  
**3. In case of complex solution/algorithms for some feature, please explain how it works**
 In case of complex solution/algorithms for some feature, please explain how it works  I use the didSet Method for dataSource. I have got two async methods and they will update to Datasource. When didSet method executes the logic(The first screen is a list view of all employees grouped by position. Groups are sorted alphabetically, employees are sorted by the last name. Each employee is unique by their full name (first name + last name) and is displayed only once in the list view.)If my async requests execute the exact time, didSet runs like a queue mechanism.
