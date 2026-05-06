import allure

def step_log(message):
    with allure.step(message):
        pass
    
def attach_screenshot(path):
    with open(path, "rb") as f:
        allure.attach(
            f.read(),
            name="Failure Screenshot",
            attachment_type=allure.attachment_type.PNG
        )