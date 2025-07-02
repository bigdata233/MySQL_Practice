from tkinter import *
root = Tk()
root.geometry("300x100")

label1 = Label(root, text="혼공 SQL은")
label2 = Label(root, text="쉽습니다.", font=("궁서체", 30), bg="blue", fg="yellow")

label1.pack()   #사용해야 화면에 나타남
label2.pack()   #사용해야 화면에 나타남

root.mainloop() # 입력 등 다양한 작업 이벤트를 처리하기 위해 필요한 부분(필수)