
#Python & Selenium:
#Automation: Youtube Video: [Play, Pause, FullScreen, Exit FullScreen]

from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.common.keys import Keys
import unittest
import time

wait=5 ## seconds


class YoutubeClickDemo(unittest.TestCase):
    def test_Clicker(self):
        self.driver = webdriver.Firefox(executable_path="c:\\Users\\Kartheek\\python\\geckodriver.exe")
        self.driver.implicitly_wait(5)
        self.driver.get("https://www.youtube.com/watch?v=AssaOWGh0ro")
        print("Step1: Maximize window of "+self.driver.title)
        self.driver.maximize_window()
        time.sleep(wait)
        self.action=ActionChains(self.driver)
        self.action1=ActionChains(self.driver)
        print ("Step2: Play Video: Click button 'k' ")
        self.action.send_keys('k').perform()
        time.sleep(wait)
        print("Step3: Pause Video: Click button 'k' ")
        self.action1.send_keys('k').perform()
        time.sleep(wait)
        print("Step4: FullScreen Mode: Click button 'f'")
        self.action.send_keys('f').perform()
        time.sleep(wait)
        print("Step5: Exit FullScreen Mode: Click Esc button")
        self.action.send_keys(Keys.ESCAPE).perform()
        time.sleep(wait)
        print("Step6: Close the browser")
        self.driver.close()

if __name__ == "__main__" :
    unittest.main()

