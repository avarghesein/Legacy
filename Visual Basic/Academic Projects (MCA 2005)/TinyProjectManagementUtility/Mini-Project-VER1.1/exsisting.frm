VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "msmask32.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form exsisting 
   Caption         =   "PROJECT EXPLORER"
   ClientHeight    =   6135
   ClientLeft      =   1410
   ClientTop       =   1680
   ClientWidth     =   9285
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "exsisting.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6135
   ScaleWidth      =   9285
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   3600
      Top             =   5160
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame fpred 
      Caption         =   "AFFECT OF PREDECESSORS"
      Height          =   735
      Left            =   120
      TabIndex        =   6
      Top             =   5280
      Width           =   3375
      Begin VB.ComboBox combopred 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   360
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.Frame fsucc 
      Caption         =   "AFFECT ON SUCCESSORS"
      Height          =   735
      Left            =   5640
      TabIndex        =   8
      Top             =   5280
      Width           =   3495
      Begin VB.ComboBox combosucc 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   480
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.CommandButton commanddate 
      Caption         =   "SAVE"
      Height          =   615
      Left            =   6960
      TabIndex        =   4
      Top             =   240
      Width           =   1695
   End
   Begin RichTextLib.RichTextBox rich1 
      Height          =   4095
      Left            =   120
      TabIndex        =   5
      Top             =   990
      Width           =   9015
      _ExtentX        =   15901
      _ExtentY        =   7223
      _Version        =   393217
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"exsisting.frx":030A
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame fdate 
      Caption         =   "ENTER STARTED DATE"
      Height          =   735
      Left            =   3360
      TabIndex        =   2
      Top             =   120
      Width           =   2775
      Begin MSMask.MaskEdBox mdate 
         Height          =   375
         Left            =   840
         TabIndex        =   3
         Top             =   240
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         _Version        =   393216
         MaxLength       =   10
         Mask            =   "99/99/9999"
         PromptChar      =   "_"
      End
   End
   Begin VB.Frame fsubtsks 
      Caption         =   "SUBTASKS FOR "
      Height          =   735
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2895
      Begin VB.ComboBox taskname 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.Menu project 
      Caption         =   "PROJECT"
      Begin VB.Menu view 
         Caption         =   "VIEW"
         Begin VB.Menu tasks 
            Caption         =   "TASKS"
         End
         Begin VB.Menu sepsub1 
            Caption         =   "-"
         End
         Begin VB.Menu projview 
            Caption         =   "PROJECT-REPORT"
         End
         Begin VB.Menu sepsub2 
            Caption         =   "-"
         End
         Begin VB.Menu gchart 
            Caption         =   "GANTT-CHART"
         End
         Begin VB.Menu sepm 
            Caption         =   "-"
         End
         Begin VB.Menu criticalpaths 
            Caption         =   "CRITICAL-PATHS"
         End
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu update 
         Caption         =   "UPDATE"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu exit 
         Caption         =   "EXIT"
      End
   End
   Begin VB.Menu pop 
      Caption         =   "PROJECTS-INFORMATION"
      Begin VB.Menu printit 
         Caption         =   "PRINT"
      End
      Begin VB.Menu temp 
         Caption         =   "-"
      End
      Begin VB.Menu fsave 
         Caption         =   "SAVE TO FILE"
      End
   End
End
Attribute VB_Name = "exsisting"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public exsist_owner As String
Dim chois As String

Private Sub combopred_Click()
 If combopred.ListCount <= 0 Or combopred.ListIndex = -1 Then
    MsgBox "No Predecessor for comparing", vbOKOnly, "No predecessor"
    Exit Sub
 End If
 If taskname.ListIndex = -1 Then
    MsgBox "No Subtask Selected", vbOKOnly, "No Selected Subtask"
    Exit Sub
 End If
 
 Call compare_task_with_preds(glob_proj.pid, taskname.ItemData(taskname.ListIndex), _
      combopred.ItemData(combopred.ListIndex), rich1)

End Sub

Private Sub combosucc_Click()
 If combosucc.ListCount <= 0 Or combosucc.ListIndex = -1 Then
    MsgBox "No Successor for comparing", vbOKOnly, "No Successor"
    Exit Sub
 End If
 If taskname.ListIndex = -1 Then
    MsgBox "No Subtask Selected", vbOKOnly, "No Selected Subtask"
    Exit Sub
 End If
 
 Call compare_task_with_succs(glob_proj.pid, taskname.ItemData(taskname.ListIndex), _
      combosucc.ItemData(combosucc.ListIndex), rich1)

End Sub

Private Sub commanddate_Click()
Dim updateflg As Integer
   
   If Not IsDate(mdate) Then
      MsgBox "YOU ENTERED A INVALID DATE", vbCritical, "INVALID DATE!!!"
      mdate.SetFocus
   Else
      If MsgBox("DO YOU REALLY WANT TO MAKE THIS CHANGE?", vbYesNo, "CONFIRM DATE FIXING!!!") = vbYes Then
            If taskname.ListIndex = -1 Then Exit Sub
            updateflg = statusofsubtask(glob_proj.pid, taskname.ItemData(taskname.ListIndex), _
            CDate(Format$(mdate)), True, rich1, False)
            commanddate.Visible = False
            fdate.Visible = False
            If updateflg <> 2 And updateflg <> 5 Then
              Call taskname_Click
            End If
      End If
  End If
  
End Sub

Private Sub criticalpaths_Click()
Dim I As Integer
Dim j As Integer
    glob_proj.pnam = Trim(glob_proj.pnam)
    rich1.SelFontName = "courier new"
    rich1.SelFontSize = 10
    rich1.SelIndent = 500
    rich1.SelHangingIndent = -250
    rich1.SelRightIndent = 100
    rich1.RightMargin = 25000
    rich1.Visible = True
    rich1 = Space(5) & vbCrLf & vbCrLf & Space(15) & "ASSUMED CRITICAL PATHS FOR THE PROJECT " & glob_proj.pnam & ",ID:" & Str(glob_proj.pid) & _
           vbCrLf & Space(15) & "***************************************"
    For I = 1 To Len(glob_proj.pnam) + 4 + Len(Str(glob_proj.pid))
        rich1.Text = rich1.Text & "*"
    Next I
    Call formattextinrtf(rich1, findvalidstring(rich1.Text), "courier new", 9)
    Call find_critical_paths(glob_proj.pid)
    I = 0
    While I <= critical_rows
        rich1.Text = rich1.Text & Space(5) & vbCrLf & vbCrLf & Space(5) & "CRITICAL PATH " & Str(I + 1) & vbCrLf & Space(5) & _
                                  "--------------"
        
        For j = 1 To Len(Str(I + 1))
            rich1.Text = rich1.Text & "-"
        Next j
        
        j = 0
        While j <= critical_paths(I).cols
            rich1.Text = rich1.Text & vbCrLf & Space(10) & critical_paths(I).arrays(j)
            j = j + 1
        Wend
        rich1.Text = rich1.Text & vbCrLf & vbCrLf & Space(5) & "CRITICAL PATH  LENGTH=" & Str(glob_proj.pdur) & " DAYS"
        I = I + 1
        rich1.Text = rich1.Text & vbCrLf & vbCrLf
    Wend
End Sub

Private Sub exit_Click()
 Unload Me
End Sub

Private Sub Form_Load()
chois = ""

Call load_combo

Me.Left = (Screen.Width - Me.Width) / 2
Me.Top = (Screen.Height - Me.Height) / 2
Me.Caption = "EXPLORING PROJECT WITH ID: " & Str(glob_proj.pid)
fsubtsks.Caption = "SUBTASKS FOR " & glob_proj.pnam

End Sub

Private Sub Form_Resize()

fpred.Left = 50
fpred.Top = IIf((Me.ScaleHeight - fpred.Height - 50) > 0, Me.ScaleHeight - fpred.Height - 50, 50)
fsucc.Left = IIf((Me.ScaleWidth - fsucc.Width - 50) > 0, Me.ScaleWidth - fsucc.Width - 50, 50)
fsucc.Top = fpred.Top
rich1.Height = IIf(Abs(fpred.Top - rich1.Top - 50) > 0, Abs(fpred.Top - rich1.Top - 50), 50)
rich1.Width = IIf((Me.Width - 350) > 0, Me.Width - 350, 50)

End Sub

Private Sub Form_Unload(cancel As Integer)
If exsist_owner = "ADMIN" Then
    adminform.Show
Else
    introduction.Show
End If
exsist_owner = ""
End Sub

Private Sub fsave_Click()
On Error GoTo cancel

If Trim(rich1.Text) <> "" Then
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800
    dialog1.ShowSave
    rich1.SaveFile dialog1.FileName, rtfRTF
    Exit Sub
Else
    Exit Sub
End If

cancel:
   MsgBox Err.Description
End Sub

Private Sub gchart_Click()
    Me.Hide
    mgarn.Show
End Sub

Private Sub mdate_KeyPress(pKey As Integer)

If pKey = 13 Then
    If IsDate(mdate) Then
        Call commanddate_Click
    Else
        MsgBox "YOU ENTERED A INVALID DATE", vbCritical, "INVALID DATE!!!"
        mdate.SetFocus
        Exit Sub
    End If
End If

If pKey = vbKeyBack Then pKey = vbKeyBack
End Sub


Private Sub printit_Click()
On Error GoTo cancel
Dim I As Integer

If Trim(rich1) <> "" Then
    rich1.SelStart = 1
    rich1.SelLength = Len(rich1)
    dialog1.PrinterDefault = True
    dialog1.ShowPrinter
    For I = 1 To dialog1.Copies
        Printer.NewPage
        rich1.SelPrint (Printer.hDC)
    Next I
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub projview_Click()
    Call hideall
    Call project_report(glob_proj.pid, rich1)
    rich1.Visible = True
End Sub

Private Sub rich1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  If Button = vbRightButton Then
    If Trim(rich1) <> "" Then
        PopupMenu pop
    End If
  End If
  
End Sub


Private Sub taskname_Click()
Dim X As New Connection
Dim Y As New Recordset

Dim updateflg As Integer
    
    fpred.Visible = False
    fsucc.Visible = False
    
    If taskname.ListIndex = -1 Then
        MsgBox "NO TASK SELECTED,SELECT ONE", vbOKOnly, "SUBTASK NOT SELECTED"
        Exit Sub
    End If
    
   If chois = "TASKVIEW" Then
        updateflg = statusofsubtask(glob_proj.pid, taskname.ItemData(taskname.ListIndex), CDate("01/01/01"), False, rich1, False)
   End If
       
   If chois = "UPDATE" Then
      
      commanddate.Visible = False
      fdate.Visible = False
      mdate = "99/99/9999"
      updateflg = statusofsubtask(glob_proj.pid, taskname.ItemData(taskname.ListIndex), CDate("01/01/01"), False, rich1, False)
      
      Select Case updateflg
        Case 1:
                fdate.Caption = "STARTED DATE(mm/dd/yyyy)"
                commanddate.Caption = "SET START DATE"
                fdate.Visible = True
                commanddate.Visible = True
                
        Case 4:
               fdate.Caption = "ENDED DATE(mm/dd/yyyy)"
               commanddate.Caption = "SET END DATE"
               fdate.Visible = True
               commanddate.Visible = True
       End Select
    
    End If
    
Set X = dn.cn
If X.State = adStateClosed Then X.Open

Select Case updateflg
    
    Case Is >= 3:
            Set Y = X.Execute("select taskname,taskid from subtasks where(" _
             & "projid=" & glob_proj.pid & " and taskid in(select distinct(taskrelated) " _
             & "from predecessortasks where(projid=" & glob_proj.pid & " and taskid=" & taskname.ItemData(taskname.ListIndex) _
             & " and taskrelated is not null)))")
             Call addtocombobox_extended(combopred, Y, "taskname", "taskid")
             If Y.RecordCount <= 0 Then
                fpred.Caption = "Task " & taskname.Text & " have no Predecessors"
             Else
                fpred.Caption = "AFFECT OF PREDECESSORS"
             End If
             fpred.Visible = True
             Y.Close
End Select

Select Case updateflg
    Case 6 To 7:
             Set Y = X.Execute("select taskname,taskid from subtasks where(" _
             & "projid=" & glob_proj.pid & " and taskid in(select distinct(taskrelated) " _
             & "from successortasks where(projid=" & glob_proj.pid & " and taskid=" & taskname.ItemData(taskname.ListIndex) _
             & " and taskrelated is not null)))")
             Call addtocombobox_extended(combosucc, Y, "taskname", "taskid")
             If Y.RecordCount <= 0 Then
                fsucc.Caption = "Task " & taskname.Text & " have no Successors"
             Else
                fsucc.Caption = "AFFECT ON SUCCESSORS "
             End If
             fsucc.Visible = True
End Select

End Sub

Private Sub tasks_Click()
    Call load_combo
    rich1.Visible = True
    fsubtsks.Visible = True
    chois = "TASKVIEW"
End Sub

Private Sub update_Click()
    Call load_combo
    rich1.Visible = True
    fsubtsks.Visible = True
    chois = "UPDATE"
End Sub

Private Sub hideall()

fpred.Visible = False
fsucc.Visible = False
pop.Visible = False
fsubtsks.Visible = False
fdate.Visible = False
commanddate.Visible = False
rich1.Text = ""
rich1.Visible = False

End Sub

Private Sub load_combo()
Dim X As New Connection
Dim Y As New Recordset

Call hideall
Set X = dn.cn
If X.State = adStateClosed Then X.Open
Set Y = X.Execute("select taskname,taskid from subtasks where projid=" & glob_proj.pid & "")
Call addtocombobox_extended(taskname, Y, "taskname", "taskid")

End Sub
