import os
import subprocess
os.environ['ANDROID_HOME'] = r'F:\Android\Sdk'
os.environ['ANDROID_SDK_ROOT'] = r'F:\Android\Sdk'
subprocess.run([
    r'F:\Documents\Projects Worked On\maraka\.fvm\flutter_sdk\bin\flutter.bat',
    'doctor',
    '-v'
], cwd=r'F:\Documents\Projects Worked On\maraka', check=False)
