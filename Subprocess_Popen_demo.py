# Agenda: To Execute a shell command. Capture it's output ( including error if any) along with return code.

import subprocess

try:
        Sub=subprocess.Popen(["psq -fu apache"],shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)

        #Sub=subprocess.Popen(["sleep 1000s"],shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)

        print(type(Sub))

        try:
                print("Process got Spawned -->{}".format(Sub.pid))
                output,error=Sub.communicate(timeout=5)
                print("\n######Output-->{}#####".format(output))
                print("\n######Error -->{}#####".format(error))
        except :
                Sub.kill()
                output_kill,error_kill=Sub.communicate()
                print("output_kill --> {}  error_kill --> {}".format(output_kill,error_kill))


        #returncode
        print("\n#####Return_Code --->{}".format(Sub.returncode))

except Exception as e:
        print("Exception Raised ---> "+str(e))




