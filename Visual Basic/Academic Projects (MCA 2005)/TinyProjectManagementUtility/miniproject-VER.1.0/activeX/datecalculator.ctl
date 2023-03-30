VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.UserControl datecalculatordemo2 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   4125
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4455
   FillStyle       =   0  'Solid
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   MaskPicture     =   "datecalculator.ctx":0000
   Picture         =   "datecalculator.ctx":030A
   ScaleHeight     =   4125
   ScaleWidth      =   4455
   Begin VB.Frame ctdate 
      Caption         =   "DATE"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   2760
      TabIndex        =   24
      Top             =   960
      Width           =   1575
      Begin VB.CommandButton dmove 
         Caption         =   "!"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Index           =   4
         Left            =   1080
         TabIndex        =   18
         Top             =   720
         Width           =   375
      End
      Begin VB.CommandButton dmove 
         Caption         =   "v"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   3
         Left            =   600
         TabIndex        =   15
         Top             =   720
         Width           =   375
      End
      Begin VB.CommandButton dmove 
         Caption         =   ">"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   600
         TabIndex        =   17
         Top             =   1200
         Width           =   375
      End
      Begin VB.CommandButton dmove 
         Caption         =   "^"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   720
         Width           =   375
      End
      Begin VB.CommandButton dmove 
         Caption         =   "<"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   120
         Picture         =   "datecalculator.ctx":0614
         TabIndex        =   16
         Top             =   1200
         Width           =   375
      End
      Begin MSComCtl2.DTPicker tdate 
         Height          =   375
         Left            =   120
         TabIndex        =   30
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         _Version        =   393216
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   20905987
         UpDown          =   -1  'True
         CurrentDate     =   36526
      End
   End
   Begin VB.Frame digits 
      Caption         =   "DIGITS/OPERATORS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2400
      Left            =   120
      TabIndex        =   23
      Top             =   1560
      Width           =   2535
      Begin VB.CommandButton clear 
         Caption         =   "CE"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2040
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   1800
         Width           =   375
      End
      Begin VB.CommandButton opr 
         Caption         =   "="
         Height          =   375
         Index           =   2
         Left            =   2040
         TabIndex        =   12
         Top             =   1320
         Width           =   375
      End
      Begin VB.CommandButton opr 
         Caption         =   "-"
         Height          =   375
         Index           =   1
         Left            =   2040
         TabIndex        =   11
         Top             =   840
         Width           =   375
      End
      Begin VB.CommandButton opr 
         Caption         =   "+"
         Height          =   375
         Index           =   0
         Left            =   2040
         TabIndex        =   10
         Top             =   360
         Width           =   375
      End
      Begin VB.CommandButton digit 
         Caption         =   "9"
         Height          =   375
         Index           =   9
         Left            =   1320
         TabIndex        =   9
         Top             =   1800
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "8"
         Height          =   375
         Index           =   8
         Left            =   720
         TabIndex        =   8
         Top             =   1800
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "7"
         Height          =   375
         Index           =   7
         Left            =   120
         TabIndex        =   7
         Top             =   1800
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "6"
         Height          =   375
         Index           =   6
         Left            =   1320
         TabIndex        =   6
         Top             =   1320
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "5"
         Height          =   375
         Index           =   5
         Left            =   720
         TabIndex        =   5
         Top             =   1320
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "4"
         Height          =   375
         Index           =   4
         Left            =   120
         TabIndex        =   4
         Top             =   1320
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "3"
         Height          =   375
         Index           =   3
         Left            =   1320
         TabIndex        =   3
         Top             =   840
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "2"
         Height          =   375
         Index           =   2
         Left            =   720
         TabIndex        =   2
         Top             =   840
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "1"
         Height          =   375
         Index           =   1
         Left            =   120
         TabIndex        =   1
         Top             =   840
         Width           =   495
      End
      Begin VB.CommandButton digit 
         Caption         =   "0"
         Height          =   375
         Index           =   0
         Left            =   720
         TabIndex        =   0
         Top             =   360
         Width           =   495
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "APPLY TO"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   2760
      TabIndex        =   19
      Top             =   2640
      Width           =   1575
      Begin VB.OptionButton yyyy 
         Caption         =   "Option3"
         Height          =   255
         Left            =   1080
         TabIndex        =   22
         Top             =   960
         Width           =   255
      End
      Begin VB.OptionButton m 
         Caption         =   "Option2"
         Height          =   255
         Left            =   1080
         TabIndex        =   21
         Top             =   600
         Width           =   255
      End
      Begin VB.OptionButton d 
         Caption         =   "Option1"
         Height          =   255
         Left            =   1080
         TabIndex        =   20
         Top             =   240
         Width           =   255
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "YEAR"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   29
         Top             =   960
         Width           =   735
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "MONTH"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   28
         Top             =   600
         Width           =   735
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "DAY"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   27
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame fresult 
      Caption         =   "DATE WINDOW"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   600
      TabIndex        =   25
      Top             =   120
      Width           =   3135
      Begin VB.TextBox datewin 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         Locked          =   -1  'True
         MaxLength       =   20
         TabIndex        =   26
         Top             =   240
         Width           =   2895
      End
   End
End
Attribute VB_Name = "datecalculatordemo2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit

Dim opavail As Boolean
Dim op1avail As Boolean
Dim op2avail As Boolean
Dim opravail As Boolean

Dim op1typedate As Boolean
Dim op2typedate As Boolean

Dim op1 As String
Dim op2 As String

Dim operator As String

Dim errflg As Boolean

Private Sub clear_Click()
  If Not errflg Then
    datewin = Str(0)
  Else
    errflg = False
  End If
     
    opavail = False
    op1avail = False
    op2avail = False
    opravail = False
End Sub

Private Sub digit_Click(I As Integer)

If Not opavail Then
    datewin = digit(I).Caption
    op1typedate = False
    opavail = True
    op1avail = True
    op1 = datewin
    Exit Sub
End If

If op1avail And Not opravail Then
    datewin = Str(Val(datewin & digit(I).Caption))
    op1 = datewin
    op1typedate = False
    Exit Sub
End If

If op1avail And opravail And (Not op2avail Or (op2avail And op2typedate)) Then
    datewin = digit(I).Caption
    op2 = datewin
    op2typedate = False
    op2avail = True
    Exit Sub
End If

If op1avail And opravail And op2avail Then
    datewin = Str(Val(datewin & digit(I).Caption))
    op2 = datewin
    op2typedate = False
End If

    
End Sub


Private Sub dmove_Click(I As Integer)
Dim strg As String
Dim flg As Integer
      
      If I = 4 Then
        Call tdate_Click
        Exit Sub
      End If
            
      If I = 0 Or I = 2 Then
        If d.Value = True Then
            If I = 0 Then
                yyyy.Value = True
            Else
                m.Value = True
            End If
        Else
            If m.Value = True Then
                If I = 0 Then
                    d.Value = True
                Else
                    yyyy.Value = True
                End If
            Else
                If I = 0 Then
                    m.Value = True
                Else
                    d.Value = True
                End If
            End If
        End If
    Else
        If d.Value = True Then
            strg = "d"
        Else
            If m.Value = True Then
                strg = "m"
            Else
                strg = "yyyy"
            End If
        End If
        flg = IIf(I = 1, 1, -1)
        tdate = DateAdd(strg, flg, tdate)
        Call tdate_Click
    End If
End Sub

Private Sub opr_Click(I As Integer)
On Error GoTo cancel
Dim strg As String
Dim tmp_date As Date
Dim tmp_num As Double

If Not opravail Then
    opravail = True
    operator = opr(I).Caption
    Exit Sub
End If

If op1avail And opravail And operator = "=" Then
    If op2avail Then
        op1 = op2
        op1typedate = op2typedate
        op2avail = False
    End If
    opravail = True
    operator = opr(I).Caption
    Exit Sub
End If
    
If op1avail And opravail And Not op2avail Then
    operator = opr(I).Caption
    Exit Sub
End If


If op1typedate And op2typedate Then
   If operator = "+" Then
      datewin = "Can't Add Two Dates"
      errflg = True
      Call clear_Click
      Exit Sub
   End If
   If d.Value = True Then
       strg = "d"
   Else
       If m.Value = True Then
           strg = "m"
        Else
            strg = "yyyy"
        End If
   End If
   datewin = Str(DateDiff(strg, CDate(Format$(op1, "mm/dd/yyyy")), CDate(Format$(op2, "mm/dd/yyyy"))))
   op1 = datewin
   opavail = True
   op1avail = True
   op1typedate = False
   op2avail = False
Else
   If op1typedate Or op2typedate Then
      If op1typedate Then
          tmp_date = CDate(Format$(op1, "mm/dd/yyyy"))
          tmp_num = Val(op2)
       Else
           tmp_date = CDate(Format$(op2, "mm/dd/yyyy"))
           tmp_num = Val(op1)
       End If
       
       If operator = "-" Then
            tmp_num = -tmp_num
       End If
            
       If d.Value = True Then
          strg = "d"
       Else
          If m.Value = True Then
             strg = "m"
          Else
              strg = "yyyy"
          End If
       End If
       datewin = Format$(Str(DateAdd(strg, tmp_num, tmp_date)), "dd-mmm-yyyy")
       op1 = datewin
       opavail = True
       op1avail = True
       op1typedate = True
       op2avail = False
   Else
       datewin = IIf(operator = "+", Val(op1) + Val(op2), Val(op1) - Val(op2))
       op1 = datewin
       opavail = True
       op1avail = True
       op1typedate = False
       op2avail = False
   End If
End If
operator = opr(I).Caption
opravail = True
  
  
Exit Sub

cancel:
    datewin = "VERY LARGE NUMBER"
    errflg = True
    Call clear_Click
    
End Sub

Private Sub tdate_Change()
    Call tdate_Click
End Sub

Private Sub tdate_Click()

If Not opavail Then
    datewin = Format$(Str(tdate), "dd-mmm-yyyy")
    op1 = datewin
    op1typedate = True
    op1avail = True
    opavail = True
    Exit Sub
End If

If (op1avail And Not opravail) Then
    datewin = Format$(Str(tdate), "dd-mmm-yyyy")
    op1 = datewin
    op1typedate = True
    op1avail = True
    opavail = True
    Exit Sub
End If

If op1avail And opravail And (Not op2avail Or (op2avail And Not op2typedate)) Then
    datewin = Format$(Str(tdate), "dd-mmm-yyyy")
    op2 = datewin
    op2typedate = True
    op2avail = True
    Exit Sub
End If

If op1avail And opravail And op2avail Then
    datewin = Format$(Str(tdate), "dd-mmm-yyyy")
    op2 = datewin
    op2typedate = True
    op2avail = True
End If
End Sub


Private Sub UserControl_Initialize()
    errflg = False
    d.Value = True
    Call clear_Click
End Sub

Private Sub UserControl_KeyPress(pKey As Integer)

    If pKey = 83 Or pKey = 115 Then
        Call dmove_Click(4)
        Exit Sub
    End If
    
    If pKey = 76 Or pKey = 108 Then
        Call dmove_Click(0)
        Exit Sub
    End If
    
    If pKey = 82 Or pKey = 114 Then
        Call dmove_Click(2)
        Exit Sub
    End If
    
    If pKey = 85 Or pKey = 117 Then
        Call dmove_Click(1)
        Exit Sub
    End If
    
    If pKey = 66 Or pKey = 98 Then
        Call dmove_Click(3)
        Exit Sub
    End If
    
    If pKey >= 48 And pKey <= 57 Then
        Call digit_Click(pKey - 48)
    Else
        Select Case Chr$(pKey)
            Case "+": Call opr_Click(0)
            Case "-": Call opr_Click(1)
            Case "=": Call opr_Click(2)
            Case "c": Call clear_Click
            Case "C": Call clear_Click
        End Select
    End If
End Sub


'''-------------properies & methods-------------'''



Public Property Get typeofoperand1() As Boolean
    typeofoperand1 = op1typedate
End Property

Public Property Let typeofoperand1(ByVal NVal As Boolean)
    op1typedate = NVal
    PropertyChanged "typeofoperand1"
End Property

Public Property Get typeofoperand2() As Boolean
    typeofoperand1 = op2typedate
End Property

Public Property Let typeofoperand2(ByVal NVal As Boolean)
    op2typedate = NVal
    PropertyChanged "typeofoperand2"
End Property
Public Property Get operatorappliedto() As String
    operatorappliedto = Switch(d.Value = True, "d", m.Value = True, "m", yyyy.Value = True, "y")
End Property

Public Property Let operatorappliedto(ByVal NVal As String)
    NVal = LCase(NVal)
    Select Case NVal
        Case "y":
                    yyyy.Value = True
        Case "m":
                    m.Value = True
        Case Else:
                    d.Value = True
    End Select
    PropertyChanged "operatorappliedto"
End Property

Private Sub UserControl_WriteProperties(pbag As PropertyBag)
    pbag.WriteProperty "typeofoperand1", op1typedate, True
    pbag.WriteProperty "typeofoperand2", op2typedate, False
    pbag.WriteProperty "operatorappliedto", Switch(d.Value = True, "d", m.Value = True, "m", yyyy.Value = True, "y"), "d"
End Sub

Private Sub UserControl_ReadProperties(pbag As PropertyBag)

    op1typedate = pbag.ReadProperty("typeofoperand1", True)
    op2typedate = pbag.ReadProperty("typeofoperand2", False)
    Select Case pbag.ReadProperty("operatorappliedto", "d")
        Case "y":
                    yyyy.Value = True
        Case "m":
                    m.Value = True
        Case Else:
                    d.Value = True
    End Select
End Sub

Public Function add(operand1 As String, operand2 As String) As String
    
opavail = True
op1avail = True
op1 = operand1
op2avail = True
op2 = operand2
opravail = True
operator = "+"
Call opr_Click(2)
add = datewin
End Function

Public Function subtract(operand1 As String, operand2 As String) As String
opavail = True
op1avail = True
op1 = operand1
op2avail = True
op2 = operand2
opravail = True
operator = "-"
Call opr_Click(2)
subtract = datewin
End Function

