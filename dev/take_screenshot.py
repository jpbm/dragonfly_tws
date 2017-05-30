from selenium import webdriver

browser=webdriver.Firefox()
browser.get('https://www.youtube.com/watch?v=1LDY_oyZrl4')
browser.save_screenshot('frame.jpg')
browser.quit()
