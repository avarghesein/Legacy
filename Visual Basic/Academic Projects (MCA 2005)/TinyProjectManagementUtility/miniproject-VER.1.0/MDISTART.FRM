VERSION 5.00
Begin VB.MDIForm mdistart 
   BackColor       =   &H8000000C&
   Caption         =   "PROJECT SHEDULER"
   ClientHeight    =   3975
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   7665
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu pshedule 
      Caption         =   "PROJECT SHEDULER"
      Begin VB.Menu loadit 
         Caption         =   "LOAD"
      End
      Begin VB.Menu exitit 
         Caption         =   "EXIT"
      End
   End
End
Attribute VB_Name = "mdistart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub exitit_Click()
 Call MDIForm_Unload(1)
 
End Sub

Private Sub loadit_Click()
  introduction.Show
End Sub


Private Sub MDIForm_Unload(Cancel As Integer)
  Unload Me
End Sub
