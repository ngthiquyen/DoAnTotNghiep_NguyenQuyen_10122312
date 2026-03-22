import allure

def attach_text(content, name="Attachment"):
    allure.attach(content, name=name, attachment_type=allure.attachment_type.TEXT)

def attach_png(path, name="Screenshot"):
    with open(path, "rb") as f:
        allure.attach(f.read(), name=name, attachment_type=allure.attachment_type.PNG)