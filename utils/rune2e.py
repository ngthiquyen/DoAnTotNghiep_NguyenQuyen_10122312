import subprocess

def run_robot_test(file_path):
    print(f"\n Running: {file_path}")

    result = subprocess.run(
        ["robot", file_path],
        text=True
    )

    return result.returncode == 0