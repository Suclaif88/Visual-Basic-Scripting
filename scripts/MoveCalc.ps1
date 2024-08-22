# Añadir el tipo WindowMover que define los métodos necesarios para mover la ventana
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class WindowMover {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll")]
        public static extern bool GetWindowRect(IntPtr hWnd, out RECT rect);

        [StructLayout(LayoutKind.Sequential)]
        public struct RECT {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        public static void MoveWindow(string windowName, int x, int y) {
            IntPtr hWnd = FindWindow(null, windowName);
            if (hWnd != IntPtr.Zero) {
                // Get the current window rect
                RECT rect;
                GetWindowRect(hWnd, out rect);

                // Move the window
                SetWindowPos(hWnd, IntPtr.Zero, x, y, rect.Right - rect.Left, rect.Bottom - rect.Top, 0x0001 | 0x0004);
            }
        }

        public static (int Width, int Height) GetScreenResolution() {
            return (System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width,
                    System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
        }
    }
"@

# Obtener la resolución de pantalla
$screenResolution = [WindowMover]::GetScreenResolution()
$screenWidth = $screenResolution.Width
$screenHeight = $screenResolution.Height

# Definir el tamaño del paso en el que moveremos la ventana
$stepX = [math]::Max(1, [math]::Floor($screenWidth / 4))  # Dividir la pantalla en 4 columnas
$stepY = [math]::Max(1, [math]::Floor($screenHeight / 4)) # Dividir la pantalla en 4 filas

# Mover la ventana de la calculadora por toda la pantalla en pasos
for ($x = 0; $x -lt $screenWidth; $x += $stepX) {
    for ($y = 0; $y -lt $screenHeight; $y += $stepY) {
        [WindowMover]::MoveWindow("Calculadora", $x, $y)
        Start-Sleep -Seconds 1 # Pausa de 1 segundo para ver el movimiento
    }
}
