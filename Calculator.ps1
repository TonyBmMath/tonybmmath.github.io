$Host.UI.RawUI.WindowTitle = "Calculator"
Write-Host Please use the GUI window that just appeared...

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object Windows.Forms.Form
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.Text = "PowerShell GUI Calculator"
$form.Size = '320,270'
$form.StartPosition = 'CenterScreen'

# Number 1 Input
$label1 = New-Object Windows.Forms.Label
$label1.Text = "First Number:"
$label1.Location = '10,20'
$form.Controls.Add($label1)

$textBox1 = New-Object Windows.Forms.TextBox
$textBox1.Location = '120,20'
$form.Controls.Add($textBox1)

# Number 2 Input
$label2 = New-Object Windows.Forms.Label
$label2.Text = "Second Number:"
$label2.Location = '10,50'
$form.Controls.Add($label2)

$textBox2 = New-Object Windows.Forms.TextBox
$textBox2.Location = '120,50'
$form.Controls.Add($textBox2)

# Operator Dropdown
$labelOp = New-Object Windows.Forms.Label
$labelOp.Text = "Operator:"
$labelOp.Location = '10,80'
$form.Controls.Add($labelOp)

$comboBox = New-Object Windows.Forms.ComboBox
$comboBox.Items.AddRange(@('+','-','*','/','%','^'))
$comboBox.Location = '120,80'
$comboBox.DropDownStyle = 'DropDownList'
$form.Controls.Add($comboBox)

# Help Icon Label (a simple "?")
$helpLabel = New-Object Windows.Forms.Label
$helpLabel.Text = "?"
$helpLabel.Location = '260,80'
$helpLabel.Size = '20,20'
$helpLabel.Font = 'Microsoft Sans Serif, 10, style=Bold'
$helpLabel.ForeColor = 'Blue'
$helpLabel.Cursor = 'Hand'
$form.Controls.Add($helpLabel)

# Tooltip Object
$tooltip = New-Object Windows.Forms.ToolTip
$tooltip.SetToolTip($helpLabel, @"
Operator Guide:
+ : Addition (e.g. 5 + 3 = 8)
- : Subtraction (e.g. 9 - 4 = 5)
* : Multiplication (e.g. 2 * 3 = 6)
/ : Division (e.g. 8 / 2 = 4)
% : Modulus (remainder, e.g. 10 % 3 = 1)
^ : Exponentiation (e.g. 2 ^ 3 = 8)
"@)

# Result Label
$resultLabel = New-Object Windows.Forms.Label
$resultLabel.Text = "Result:"
$resultLabel.Location = '10,140'
$resultLabel.Size = '280,20'
$form.Controls.Add($resultLabel)

# Calculate Button
$calcButton = New-Object Windows.Forms.Button
$calcButton.Text = "Calculate"
$calcButton.Location = '80,180'
$calcButton.Add_Click({
    $num1 = 0
    $num2 = 0
    $valid1 = [double]::TryParse($textBox1.Text, [ref]$num1)
    $valid2 = [double]::TryParse($textBox2.Text, [ref]$num2)
    $op = $comboBox.SelectedItem

    if (-not ($valid1 -and $valid2)) {
        [System.Windows.Forms.MessageBox]::Show(
            "Please enter valid numbers.",
            "Input Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        return
    }

    try {
        switch ($op) {
            '+' { $result = $num1 + $num2 }
            '-' { $result = $num1 - $num2 }
            '*' { $result = $num1 * $num2 }
            '/' {
                if ($num2 -eq 0) {
                    [System.Windows.Forms.MessageBox]::Show(
                        "Cannot divide by zero.",
                        "Division Error",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Error
                    )
                    return
                } else {
                    $result = $num1 / $num2
                }
            }
            '%' { $result = $num1 % $num2 }
            '^' { $result = [math]::Pow($num1, $num2) }
            default {
                [System.Windows.Forms.MessageBox]::Show(
                    "Invalid operator selected.",
                    "Operator Error",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Warning
                )
                return
            }
        }

        $resultLabel.Text = "Result: $result"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            "An unexpected error occurred.",
            "Calculation Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})
$form.Controls.Add($calcButton)

# Clear Button
$clearButton = New-Object Windows.Forms.Button
$clearButton.Text = "Clear"
$clearButton.Location = '170,180'
$clearButton.Add_Click({
    $textBox1.Clear()
    $textBox2.Clear()
    $comboBox.SelectedIndex = -1
    $resultLabel.Text = "Result:"
})
$form.Controls.Add($clearButton)

# Enable Enter key to trigger calculation
$form.AcceptButton = $calcButton

# Run the form
[Windows.Forms.Application]::EnableVisualStyles()
$form.ShowDialog()