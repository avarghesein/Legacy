VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.MDIForm mdi 
   BackColor       =   &H80000004&
   Caption         =   "MDIForm1"
   ClientHeight    =   6720
   ClientLeft      =   165
   ClientTop       =   555
   ClientWidth     =   8550
   Icon            =   "mdi.frx":0000
   LinkTopic       =   "MDIForm1"
   Picture         =   "mdi.frx":0442
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin ComctlLib.ProgressBar pbar 
      Align           =   2  'Align Bottom
      Height          =   210
      Left            =   0
      TabIndex        =   1
      ToolTipText     =   "Shows the real progress in solving the subproblems in Branch and Bound Method."
      Top             =   6240
      Width           =   8550
      _ExtentX        =   15081
      _ExtentY        =   370
      _Version        =   327682
      Appearance      =   0
      MousePointer    =   2
   End
   Begin ComctlLib.StatusBar stat 
      Align           =   2  'Align Bottom
      Height          =   270
      Left            =   0
      TabIndex        =   0
      ToolTipText     =   "State of the solving procedure in Branch and Bound Method."
      Top             =   6450
      Width           =   8550
      _ExtentX        =   15081
      _ExtentY        =   476
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            Object.Width           =   159
            MinWidth        =   2
            TextSave        =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Menu bbm 
      Caption         =   "&Branch And Bound Method"
      Begin VB.Menu bbmsolution 
         Caption         =   "Solution"
         Shortcut        =   ^S
      End
      Begin VB.Menu subprblms 
         Caption         =   "Subproblems"
         Index           =   0
      End
   End
   Begin VB.Menu mspj2 
      Caption         =   "&Sequential Problem"
      Begin VB.Menu sheds 
         Caption         =   "Job Schedules"
         Index           =   0
      End
   End
   Begin VB.Menu mexit 
      Caption         =   "E&xit!"
   End
End
Attribute VB_Name = "mdi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public hold As Long
Public istran As Boolean
Public chois As String
Dim indx As Integer
Public pid As Long
Dim subp() As subprblm
Dim detp() As subdetails

Private Sub bbmsolution_Click()
On Error GoTo xit
Dim Y As New Recordset
Dim i As Integer
Dim subindx As Integer
Dim first As Boolean
Dim n As Integer
Dim maxflg As Boolean
Dim tmp As String

Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=0)")
maxflg = IIf(Y.Fields("e_type") = "MA", True, False)
Set Y = dn.cn.Execute("select n from lpp_main where pid=" & pid)
n = Y.Fields("n")

subindx = -1
first = True
For i = 0 To indx Step 1
    If subp(i).state = 1 Then
        If first Then
            subindx = i
            first = False
        Else
            If (maxflg And rat1_gret_rat2(detp(i).x(n), detp(subindx).x(n))) Or _
               (Not maxflg And rat1_less_rat2(detp(i).x(n), detp(subindx).x(n))) Then
               
               subindx = i
            
            End If
        End If
    End If
Next i

If subindx = -1 Then
    MsgBox "NO INTEGER SOLUTION BY THIS METHOD"
    stat.Panels(1).Text = "Failure!!!, Branch And Bound Method failed."
Else
    stat.Panels(1).Text = "Success!!!,Solution obtained."
    tmp = "SOLUTION-(SUB PROBLEM " & str(subindx) & ")" & vbCrLf & vbCrLf
    For i = 0 To n - 1 Step 1
        tmp = tmp & "X" & str(i + 1) & "=" & detp(subindx).x(i) & vbCrLf
    Next i
    tmp = tmp & vbCrLf & IIf(maxflg, "MAX(Z)=", "MIN(Z)=") & detp(subindx).x(n)
    MsgBox tmp
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub MDIForm_Load()
On Error GoTo xit
Dim i As Long

bbm.Visible = False
mspj2.Visible = False
pbar.Visible = False
stat.Visible = False

If chois = "SPJ2" Then
    Me.HelpContextID = 10
    mspj2.Visible = True
    Me.sheds(0).Caption = "Schedule-1" & IIf(0 = job_mx.optimal_schedule, " : (OPTIMAL-SCHEDULE).", ".")
    For i = 1 To job_mx.cnt Step 1
        Load Me.sheds.item(i)
        Me.sheds(i).Caption = "Schedule-" & Trim(str(i + 1)) & IIf(i = job_mx.optimal_schedule, " : (Optimal-Schedule).", ".")
    Next i
End If
    

If chois = "BBM" Then
    Me.HelpContextID = 7
    pbar.Visible = True
    stat.Visible = True
    pbar.Enabled = True
    stat.Panels(1).Text = "Please wait!!!, Solving procedure in progress."
    Me.Visible = False
    Call connect
    If hold = 1 And istran Then
        '-------transaction initiated earlier;
    Else
       dn.cn.BeginTrans
    End If
    ReDim subp(0) As subprblm
    ReDim detp(0) As subdetails
    subp(0).id = pid
    subp(0).state = 0
    subp(0).subcnt = "0"
    bbm.Visible = True
    indx = 0
    bbm.Visible = True
    subprblms(0).Caption = "0.Main Problem(Sub-Problem 0)"
    subprblms(0).Visible = True
    Me.Caption = "Branch And Bound Method"
    If generate_subprblms(subp, detp, indx, pbar) Then
        Call bbmsolution_Click
    Else
        stat.Panels(1).Text = "Failure!!!,Branch And Bound Method failed."
    End If
    pbar.Visible = False
    Me.Visible = True
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub MDIForm_Unload(cancel As Integer)
    If hold = 0 Then
        dn.cn.RollbackTrans
        or_form1.Show
    ElseIf hold = 2 Then
        spj2.Show
    ElseIf hold = 1 Then
        foptions.Show
        If Not istran Then
            dn.cn.RollbackTrans
        End If
    End If
End Sub

Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub sheds_Click(Index As Integer)
On Error GoTo xit
Dim x As New spj2_mdi
    x.optimal = Index
    x.Show
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub subprblms_Click(Index As Integer)
On Error GoTo xit
Dim frm As New lpp_bbm

frm.type_solve = "BBM"
frm.pid = subp(Index).id
frm.Caption = IIf(Index <> 0, "Subproblem No:" & str(Index), "Main Problem")
frm.Show
Exit Sub
xit:
    Call error_me(Me)
End Sub
