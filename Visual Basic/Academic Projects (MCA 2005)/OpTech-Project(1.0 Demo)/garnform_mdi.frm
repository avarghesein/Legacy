VERSION 5.00
Begin VB.Form grapher_mdi 
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000004&
   Caption         =   "Graph Generator"
   ClientHeight    =   5505
   ClientLeft      =   1230
   ClientTop       =   2265
   ClientWidth     =   9450
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   HelpContextID   =   11
   Icon            =   "garnform_mdi.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   367
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   630
   WindowState     =   2  'Maximized
   Begin VB.PictureBox garnpic 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFC0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5295
      Left            =   0
      ScaleHeight     =   349
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   613
      TabIndex        =   0
      ToolTipText     =   "Meant for showing Graphics related to SP."
      Top             =   120
      Width           =   9255
   End
   Begin VB.Menu mexit 
      Caption         =   "E&xit!"
   End
End
Attribute VB_Name = "grapher_mdi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public indx As Long
Public hold As Long
Dim pl As xy_plane
Dim errflg As Boolean
Dim ids As optimal_spj2
Dim rawshed As job_gp


Private Sub Form_load()
On Error GoTo xit
    
    errflg = False
    If hold = 0 Then
        Call create_raw_schedule(seqj2, rawshed)
        Call create_idles(job_mx, indx, ids, seqj2)
    End If
    Call Form_Resize
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Resize()
On Error GoTo xit
garnpic.Cls
garnpic.left = 0
garnpic.Top = 0
garnpic.Height = Me.ScaleHeight
garnpic.Width = Me.ScaleWidth
If hold = 0 Then
    If Not errflg Then
        Call initialize_graphic_spj2(pl, garnpic, seqj2, ids)
        If pl.x_max = 0 Or pl.y_max = 0 Then
            errflg = True
            Exit Sub
        End If
        Call draw_graph_spj2(garnpic, ids, rawshed, pl, job_mx, indx)
    Else
        garnpic.CurrentX = garnpic.ScaleWidth / 2 - 225
        garnpic.CurrentY = garnpic.ScaleHeight / 2
        garnpic.FontBold = True
        garnpic.ForeColor = RGB(250, 0, 0)
        garnpic.FontSize = 12
        garnpic.Print "Error, Unable to display Graphics." + "Please choose close."
   End If
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub xit_Click()
    Unload Me
End Sub

Private Sub mexit_Click()
    Unload Me
End Sub
