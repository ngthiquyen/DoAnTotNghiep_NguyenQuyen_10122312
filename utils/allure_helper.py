import os
import allure
from robot.api.deco import keyword


@keyword("Step Log")
def step_log(message):
    with allure.step(str(message)):
        pass


@keyword("Attach Screenshot")
def attach_screenshot(path):
    if not os.path.exists(path):
        raise FileNotFoundError(f"Screenshot not found: {path}")

    allure.attach.file(
        path,
        name="Failure Screenshot",
        attachment_type=allure.attachment_type.PNG
    )