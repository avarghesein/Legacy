VERSION 5.00
Begin VB.MDIForm mgarn 
   BackColor       =   &H8000000C&
   Caption         =   "GANTT CHART GENERATOR"
   ClientHeight    =   6240
   ClientLeft      =   1320
   ClientTop       =   1680
   ClientWidth     =   9465
   Icon            =   "mgarn.frx":0000
   LinkTopic       =   "MDIForm1"
   Begin VB.Menu gtype 
      Caption         =   "GANTT-TYPES"
      Begin VB.Menu estart 
         Caption         =   "EARLY START"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu lstart 
         Caption         =   "LATE START"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu rstart 
         Caption         =   "REAL START"
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu path 
         Caption         =   "PATHS"
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu cpaths 
         Caption         =   "CRITICAL-PATHS"
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu exit 
         Caption         =   "EXIT"
      End
   End
End
Attribute VB_Name = "mgarn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public garn_type As String

Private Sub cpaths_Click()
Dim X As New garnform
garn_type = "CPATH"
X.Caption = "CRITICAL PATHS UNDER THE PROJECT WITH ID:" & glob_proj.pid
X.Show
End Sub

Private Sub estart_Click()
    Dim X As New garnform
    garn_type = "EARLY"
    X.Caption = "EARLY START GANTT CHART FOR PROJECT " & glob_proj.pnam
    X.Show
End Sub

Private Sub exit_Click()
    Unload Me
End Sub

Private Sub lstart_Click()
 Dim X As New garnform
 garn_type = "LATE"
 X.Caption = "LATE START GANTT CHART FOR PROJECT " & glob_proj.pnam
 X.Show
End Sub

Private Sub MDIForm_Load()
    Me.Caption = "GANTT CHART GENERATOR FOR PROJECT WITH ID:" & Str(glob_proj.pid)
End Sub


Private Sub MDIForm_Unload(cancel As Integer)
    exsisting.Show
End Sub

Private Sub path_Click()
Dim X As New garnform
garn_type = "PATH"
X.Caption = "PATHS UNDER THE PROJECT WITH ID:" & glob_proj.pid
X.Show
End Sub

Private Sub rstart_Click()
 Dim X As New garnform
 garn_type = "REAL"
 X.Caption = "REAL START GANTT CHART FOR PROJECT " & glob_proj.pnam
 X.Show
    
End Sub
