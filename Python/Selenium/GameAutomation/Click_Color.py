####
#Problem Statement:
#Color sense test 2: Find same color with top color bar:Find more colors in 60 seconds
#Using Python and Selenium automating the above problem statement.
#YoutubeChannel:TechyAnand



from selenium import webdriver

driver = webdriver.Firefox(executable_path="c:\\Users\\Kartheek\\python\\geckodriver.exe")
driver.get("https://zzzscore.com/color2/en/")
driver.implicitly_wait(10)

def Click_Color():
    try:
        topBarColor = driver.find_element_by_xpath("//*[@id='mainColor']").get_attribute('style').split(': ')[-1]
        gridElements = driver.find_elements_by_xpath("//div[contains(@style,'display: block')]")
        for gridObject in gridElements:
            if str(topBarColor) in str(gridObject.get_attribute('style')):gridObject.click()
    except:
        lastPage =driver.find_element_by_xpath('/html/body/div[1]/div[2]/div[2]/strong')
        print("Your_score in 60 Seconds (Number of Colors Selected) : "+ lastPage.text)
        return 1

while True:
     Status=Click_Color()
     if Status == 1:
          print("Job is done")
          break




