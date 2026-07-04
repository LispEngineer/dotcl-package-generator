;;; Generated automatically. Do not edit.
;;; Class: System.Console
;;; Generator Version: 31
;;; Creation Date: 2026-07-04T16:50:34Z

(cl:in-package :system-console)

(cl:defconstant <type> (dotnet:resolve-type "System.Console"))
(cl:defconstant <type-str> "System.Console")
(cl:defconstant <creation> "2026-07-04T16:50:34Z")
(cl:defconstant <version> 31)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.Console")))

(cl:define-symbol-macro caps-lock (dotnet:static <type-str> "CapsLock"))
(cl:setf (cl:documentation (cl:quote caps-lock) (cl:quote cl:variable)) "Gets a value indicating whether the CAPS LOCK keyboard toggle is turned on or turned off.")

(cl:define-symbol-macro error (dotnet:static <type-str> "Error"))
(cl:setf (cl:documentation (cl:quote error) (cl:quote cl:variable)) "Gets the standard error output stream.")

(cl:define-symbol-macro in (dotnet:static <type-str> "In"))
(cl:setf (cl:documentation (cl:quote in) (cl:quote cl:variable)) "Gets the standard input stream.")

(cl:define-symbol-macro error-redirected? (dotnet:static <type-str> "IsErrorRedirected"))
(cl:setf (cl:documentation (cl:quote error-redirected?) (cl:quote cl:variable)) "Gets a value that indicates whether the error output stream has been redirected from the standard error stream.")

(cl:define-symbol-macro input-redirected? (dotnet:static <type-str> "IsInputRedirected"))
(cl:setf (cl:documentation (cl:quote input-redirected?) (cl:quote cl:variable)) "Gets a value that indicates whether input has been redirected from the standard input stream.")

(cl:define-symbol-macro output-redirected? (dotnet:static <type-str> "IsOutputRedirected"))
(cl:setf (cl:documentation (cl:quote output-redirected?) (cl:quote cl:variable)) "Gets a value that indicates whether output has been redirected from the standard output stream.")

(cl:define-symbol-macro key-available (dotnet:static <type-str> "KeyAvailable"))
(cl:setf (cl:documentation (cl:quote key-available) (cl:quote cl:variable)) "Gets a value indicating whether a key press is available in the input stream.")

(cl:define-symbol-macro largest-window-height (dotnet:static <type-str> "LargestWindowHeight"))
(cl:setf (cl:documentation (cl:quote largest-window-height) (cl:quote cl:variable)) "Gets the largest possible number of console window rows, based on the current font and screen resolution.")

(cl:define-symbol-macro largest-window-width (dotnet:static <type-str> "LargestWindowWidth"))
(cl:setf (cl:documentation (cl:quote largest-window-width) (cl:quote cl:variable)) "Gets the largest possible number of console window columns, based on the current font and screen resolution.")

(cl:define-symbol-macro number-lock (dotnet:static <type-str> "NumberLock"))
(cl:setf (cl:documentation (cl:quote number-lock) (cl:quote cl:variable)) "Gets a value indicating whether the NUM LOCK keyboard toggle is turned on or turned off.")

(cl:define-symbol-macro out (dotnet:static <type-str> "Out"))
(cl:setf (cl:documentation (cl:quote out) (cl:quote cl:variable)) "Gets the standard output stream.")

(cl:defun background-color ()
  "Gets or sets the background color of the console."
  (dotnet:static <type-str> "BackgroundColor"))

(cl:defun (cl:setf background-color) (new-value)
  "Gets or sets the background color of the console."
  (cl:setf (dotnet:static <type-str> "BackgroundColor") new-value))

(cl:defun buffer-height ()
  "Gets or sets the height of the buffer area."
  (dotnet:static <type-str> "BufferHeight"))

(cl:defun (cl:setf buffer-height) (new-value)
  "Gets or sets the height of the buffer area."
  (cl:setf (dotnet:static <type-str> "BufferHeight") new-value))

(cl:defun buffer-width ()
  "Gets or sets the width of the buffer area."
  (dotnet:static <type-str> "BufferWidth"))

(cl:defun (cl:setf buffer-width) (new-value)
  "Gets or sets the width of the buffer area."
  (cl:setf (dotnet:static <type-str> "BufferWidth") new-value))

(cl:defun cursor-left ()
  "Gets or sets the column position of the cursor within the buffer area."
  (dotnet:static <type-str> "CursorLeft"))

(cl:defun (cl:setf cursor-left) (new-value)
  "Gets or sets the column position of the cursor within the buffer area."
  (cl:setf (dotnet:static <type-str> "CursorLeft") new-value))

(cl:defun cursor-size ()
  "Gets or sets the height of the cursor within a character cell."
  (dotnet:static <type-str> "CursorSize"))

(cl:defun (cl:setf cursor-size) (new-value)
  "Gets or sets the height of the cursor within a character cell."
  (cl:setf (dotnet:static <type-str> "CursorSize") new-value))

(cl:defun cursor-top ()
  "Gets or sets the row position of the cursor within the buffer area."
  (dotnet:static <type-str> "CursorTop"))

(cl:defun (cl:setf cursor-top) (new-value)
  "Gets or sets the row position of the cursor within the buffer area."
  (cl:setf (dotnet:static <type-str> "CursorTop") new-value))

(cl:defun cursor-visible ()
  "Gets or sets a value indicating whether the cursor is visible."
  (dotnet:static <type-str> "CursorVisible"))

(cl:defun (cl:setf cursor-visible) (new-value)
  "Gets or sets a value indicating whether the cursor is visible."
  (cl:setf (dotnet:static <type-str> "CursorVisible") new-value))

(cl:defun foreground-color ()
  "Gets or sets the foreground color of the console."
  (dotnet:static <type-str> "ForegroundColor"))

(cl:defun (cl:setf foreground-color) (new-value)
  "Gets or sets the foreground color of the console."
  (cl:setf (dotnet:static <type-str> "ForegroundColor") new-value))

(cl:defun input-encoding ()
  "Gets or sets the encoding the console uses to read input."
  (dotnet:static <type-str> "InputEncoding"))

(cl:defun (cl:setf input-encoding) (new-value)
  "Gets or sets the encoding the console uses to read input."
  (cl:setf (dotnet:static <type-str> "InputEncoding") new-value))

(cl:defun output-encoding ()
  "Gets or sets the encoding the console uses to write output."
  (dotnet:static <type-str> "OutputEncoding"))

(cl:defun (cl:setf output-encoding) (new-value)
  "Gets or sets the encoding the console uses to write output."
  (cl:setf (dotnet:static <type-str> "OutputEncoding") new-value))

(cl:defun title ()
  "Gets or sets the title to display in the console title bar."
  (dotnet:static <type-str> "Title"))

(cl:defun (cl:setf title) (new-value)
  "Gets or sets the title to display in the console title bar."
  (cl:setf (dotnet:static <type-str> "Title") new-value))

(cl:defun treat-control-c-as-input ()
  "Gets or sets a value indicating whether the combination of the System.ConsoleModifiers.Control modifier key and System.ConsoleKey.C console key (Ctrl+C) is treated as ordinary input or as an interruption that is handled by the operating system."
  (dotnet:static <type-str> "TreatControlCAsInput"))

(cl:defun (cl:setf treat-control-c-as-input) (new-value)
  "Gets or sets a value indicating whether the combination of the System.ConsoleModifiers.Control modifier key and System.ConsoleKey.C console key (Ctrl+C) is treated as ordinary input or as an interruption that is handled by the operating system."
  (cl:setf (dotnet:static <type-str> "TreatControlCAsInput") new-value))

(cl:defun window-height ()
  "Gets or sets the height of the console window area."
  (dotnet:static <type-str> "WindowHeight"))

(cl:defun (cl:setf window-height) (new-value)
  "Gets or sets the height of the console window area."
  (cl:setf (dotnet:static <type-str> "WindowHeight") new-value))

(cl:defun window-left ()
  "Gets or sets the leftmost position of the console window area relative to the screen buffer."
  (dotnet:static <type-str> "WindowLeft"))

(cl:defun (cl:setf window-left) (new-value)
  "Gets or sets the leftmost position of the console window area relative to the screen buffer."
  (cl:setf (dotnet:static <type-str> "WindowLeft") new-value))

(cl:defun window-top ()
  "Gets or sets the top position of the console window area relative to the screen buffer."
  (dotnet:static <type-str> "WindowTop"))

(cl:defun (cl:setf window-top) (new-value)
  "Gets or sets the top position of the console window area relative to the screen buffer."
  (cl:setf (dotnet:static <type-str> "WindowTop") new-value))

(cl:defun window-width ()
  "Gets or sets the width of the console window."
  (dotnet:static <type-str> "WindowWidth"))

(cl:defun (cl:setf window-width) (new-value)
  "Gets or sets the width of the console window."
  (cl:setf (dotnet:static <type-str> "WindowWidth") new-value))

(cl:defun beep (cl:&optional (frequency cl:nil supplied-frequency) (duration cl:nil supplied-duration))
  "Master wrapper for System.Console.Beep overloads. Dispatches at runtime.

Beep() -> Void
  Summary: Plays the sound of a beep through the console speaker.

Beep(Int32, Int32) -> Void
  Summary: Plays the sound of a beep of a specified frequency and duration through the console speaker.
  Parameters:
    - frequency (System.Int32): The frequency of the beep, ranging from 37 to 32767 hertz.
    - duration (System.Int32): The duration of the beep measured in milliseconds.
"
  (cl:cond
    ((cl:and supplied-frequency (cl:numberp frequency) supplied-duration (cl:numberp duration))
     (dotnet:static <type-str> "Beep" frequency duration))
    ((cl:and (cl:not supplied-frequency) (cl:not supplied-duration))
     (dotnet:static <type-str> "Beep"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "Beep"
                    :supplied-args (cl:append (cl:when supplied-frequency (cl:list :frequency frequency)) (cl:when supplied-duration (cl:list :duration duration)))))))

(cl:defun clear ()
  "Summary: Clears the console buffer and corresponding console window of display information.
"
  (dotnet:static <type-str> "Clear"))

(cl:defun get-cursor-position ()
  "Summary: Gets the position of the cursor.
Returns: The column and row position of the cursor.
"
  (dotnet:static <type-str> "GetCursorPosition"))

(cl:defun move-buffer-area (source-left source-top source-width source-height target-left target-top cl:&optional (source-char cl:nil supplied-source-char) (source-fore-color cl:nil supplied-source-fore-color) (source-back-color cl:nil supplied-source-back-color))
  "Master wrapper for System.Console.MoveBufferArea overloads. Dispatches at runtime.

MoveBufferArea(Int32, Int32, Int32, Int32, Int32, Int32) -> Void
  Summary: Copies a specified source area of the screen buffer to a specified destination area.
  Parameters:
    - source-left (System.Int32): The leftmost column of the source area.
    - source-top (System.Int32): The topmost row of the source area.
    - source-width (System.Int32): The number of columns in the source area.
    - source-height (System.Int32): The number of rows in the source area.
    - target-left (System.Int32): The leftmost column of the destination area.
    - target-top (System.Int32): The topmost row of the destination area.

MoveBufferArea(Int32, Int32, Int32, Int32, Int32, Int32, Char, ConsoleColor, ConsoleColor) -> Void
  Summary: Copies a specified source area of the screen buffer to a specified destination area.
  Parameters:
    - source-left (System.Int32): The leftmost column of the source area.
    - source-top (System.Int32): The topmost row of the source area.
    - source-width (System.Int32): The number of columns in the source area.
    - source-height (System.Int32): The number of rows in the source area.
    - target-left (System.Int32): The leftmost column of the destination area.
    - target-top (System.Int32): The topmost row of the destination area.
    - source-char (System.Char): The character used to fill the source area.
    - source-fore-color (System.ConsoleColor): The foreground color used to fill the source area.
    - source-back-color (System.ConsoleColor): The background color used to fill the source area.
"
  (cl:cond
    ((cl:and (cl:numberp source-left) (cl:numberp source-top) (cl:numberp source-width) (cl:numberp source-height) (cl:numberp target-left) (cl:numberp target-top) supplied-source-char (cl:or (cl:null source-char) (dotnet:object-type source-char)) supplied-source-fore-color (cl:or (cl:null source-fore-color) (dotnet:object-type source-fore-color)) supplied-source-back-color (cl:or (cl:null source-back-color) (dotnet:object-type source-back-color)))
     (dotnet:static <type-str> "MoveBufferArea" source-left source-top source-width source-height target-left target-top source-char source-fore-color source-back-color))
    ((cl:and (cl:numberp source-left) (cl:numberp source-top) (cl:numberp source-width) (cl:numberp source-height) (cl:numberp target-left) (cl:numberp target-top) (cl:not supplied-source-char) (cl:not supplied-source-fore-color) (cl:not supplied-source-back-color))
     (dotnet:static <type-str> "MoveBufferArea" source-left source-top source-width source-height target-left target-top))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "MoveBufferArea"
                    :supplied-args (cl:append (cl:list :source-left source-left) (cl:list :source-top source-top) (cl:list :source-width source-width) (cl:list :source-height source-height) (cl:list :target-left target-left) (cl:list :target-top target-top) (cl:when supplied-source-char (cl:list :source-char source-char)) (cl:when supplied-source-fore-color (cl:list :source-fore-color source-fore-color)) (cl:when supplied-source-back-color (cl:list :source-back-color source-back-color)))))))

(cl:defun open-standard-error (cl:&optional (buffer-size cl:nil supplied-buffer-size))
  "Master wrapper for System.Console.OpenStandardError overloads. Dispatches at runtime.

OpenStandardError() -> Stream
  Summary: Acquires the standard error stream.
  Returns: The standard error stream.

OpenStandardError(Int32) -> Stream
  Summary: Acquires the standard error stream, which is set to a specified buffer size.
  Returns: The standard error stream.
  Parameters:
    - buffer-size (System.Int32): This parameter has no effect, but its value must be greater than or equal to zero.
"
  (cl:cond
    ((cl:and supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:static <type-str> "OpenStandardError" buffer-size))
    ((cl:and (cl:not supplied-buffer-size))
     (dotnet:static <type-str> "OpenStandardError"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "OpenStandardError"
                    :supplied-args (cl:append (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)))))))

(cl:defun open-standard-input (cl:&optional (buffer-size cl:nil supplied-buffer-size))
  "Master wrapper for System.Console.OpenStandardInput overloads. Dispatches at runtime.

OpenStandardInput() -> Stream
  Summary: Acquires the standard input stream.
  Returns: The standard input stream.

OpenStandardInput(Int32) -> Stream
  Summary: Acquires the standard input stream, which is set to a specified buffer size.
  Returns: The standard input stream.
  Parameters:
    - buffer-size (System.Int32): This parameter has no effect, but its value must be greater than or equal to zero.
"
  (cl:cond
    ((cl:and supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:static <type-str> "OpenStandardInput" buffer-size))
    ((cl:and (cl:not supplied-buffer-size))
     (dotnet:static <type-str> "OpenStandardInput"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "OpenStandardInput"
                    :supplied-args (cl:append (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)))))))

(cl:defun open-standard-output (cl:&optional (buffer-size cl:nil supplied-buffer-size))
  "Master wrapper for System.Console.OpenStandardOutput overloads. Dispatches at runtime.

OpenStandardOutput() -> Stream
  Summary: Acquires the standard output stream.
  Returns: The standard output stream.

OpenStandardOutput(Int32) -> Stream
  Summary: Acquires the standard output stream, which is set to a specified buffer size.
  Returns: The standard output stream.
  Parameters:
    - buffer-size (System.Int32): This parameter has no effect, but its value must be greater than or equal to zero.
"
  (cl:cond
    ((cl:and supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:static <type-str> "OpenStandardOutput" buffer-size))
    ((cl:and (cl:not supplied-buffer-size))
     (dotnet:static <type-str> "OpenStandardOutput"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "OpenStandardOutput"
                    :supplied-args (cl:append (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)))))))

(cl:defun read ()
  "Summary: Reads the next character from the standard input stream.
Returns: The next character from the input stream, or negative one (-1) if there are currently no more characters to be read.
"
  (dotnet:static <type-str> "Read"))

(cl:defun read-key (cl:&optional (intercept cl:nil supplied-intercept))
  "Master wrapper for System.Console.ReadKey overloads. Dispatches at runtime.

ReadKey() -> ConsoleKeyInfo
  Summary: Obtains the next character or function key pressed by the user. The pressed key is displayed in the console window.
  Returns: An object that describes the System.ConsoleKey constant and Unicode character, if any, that correspond to the pressed console key. The System.ConsoleKeyInfo object also describes, in a bitwise combination of System.ConsoleModifiers values, whether one or more Shift, Alt, or Ctrl modifier keys was pressed simultaneously with the console key.

ReadKey(Boolean) -> ConsoleKeyInfo
  Summary: Obtains the next character or function key pressed by the user. The pressed key is optionally displayed in the console window.
  Returns: An object that describes the System.ConsoleKey constant and Unicode character, if any, that correspond to the pressed console key. The System.ConsoleKeyInfo object also describes, in a bitwise combination of System.ConsoleModifiers values, whether one or more Shift, Alt, or Ctrl modifier keys was pressed simultaneously with the console key.
  Parameters:
    - intercept (System.Boolean): Determines whether to display the pressed key in the console window. to not display the pressed key; otherwise, .
"
  (cl:cond
    ((cl:and supplied-intercept (cl:typep intercept 'cl:boolean))
     (dotnet:static <type-str> "ReadKey" intercept))
    ((cl:and (cl:not supplied-intercept))
     (dotnet:static <type-str> "ReadKey"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "ReadKey"
                    :supplied-args (cl:append (cl:when supplied-intercept (cl:list :intercept intercept)))))))

(cl:defun read-line ()
  "Summary: Reads the next line of characters from the standard input stream.
Returns: The next line of characters from the input stream, or if no more lines are available.
"
  (dotnet:static <type-str> "ReadLine"))

(cl:defun reset-color ()
  "Summary: Sets the foreground and background console colors to their defaults.
"
  (dotnet:static <type-str> "ResetColor"))

(cl:defun set-buffer-size (width height)
  "Summary: Sets the height and width of the screen buffer area to the specified values.
Parameters:
  - width (System.Int32): The width of the buffer area measured in columns.
  - height (System.Int32): The height of the buffer area measured in rows.
"
  (dotnet:static <type-str> "SetBufferSize" (cl:the (dotnet "System.Int32") width) (cl:the (dotnet "System.Int32") height)))

(cl:defun set-cursor-position (left top)
  "Summary: Sets the position of the cursor.
Parameters:
  - left (System.Int32): The column position of the cursor. Columns are numbered from left to right starting at 0.
  - top (System.Int32): The row position of the cursor. Rows are numbered from top to bottom starting at 0.
"
  (dotnet:static <type-str> "SetCursorPosition" (cl:the (dotnet "System.Int32") left) (cl:the (dotnet "System.Int32") top)))

(cl:defun set-error (new-error)
  "Summary: Sets the System.Console.Error property to the specified System.IO.TextWriter object.
Parameters:
  - new-error (System.IO.TextWriter): A stream that is the new standard error output.
"
  (dotnet:static <type-str> "SetError" (cl:the (dotnet "System.IO.TextWriter") new-error)))

(cl:defun set-in (new-in)
  "Summary: Sets the System.Console.In property to the specified System.IO.TextReader object.
Parameters:
  - new-in (System.IO.TextReader): A stream that is the new standard input.
"
  (dotnet:static <type-str> "SetIn" (cl:the (dotnet "System.IO.TextReader") new-in)))

(cl:defun set-out (new-out)
  "Summary: Sets the System.Console.Out property to target the System.IO.TextWriter object.
Parameters:
  - new-out (System.IO.TextWriter): A text writer to be used as the new standard output.
"
  (dotnet:static <type-str> "SetOut" (cl:the (dotnet "System.IO.TextWriter") new-out)))

(cl:defun set-window-position (left top)
  "Summary: Sets the position of the console window relative to the screen buffer.
Parameters:
  - left (System.Int32): The column position of the upper left corner of the console window.
  - top (System.Int32): The row position of the upper left corner of the console window.
"
  (dotnet:static <type-str> "SetWindowPosition" (cl:the (dotnet "System.Int32") left) (cl:the (dotnet "System.Int32") top)))

(cl:defun set-window-size (width height)
  "Summary: Sets the height and width of the console window to the specified values.
Parameters:
  - width (System.Int32): The width of the console window measured in columns.
  - height (System.Int32): The height of the console window measured in rows.
"
  (dotnet:static <type-str> "SetWindowSize" (cl:the (dotnet "System.Int32") width) (cl:the (dotnet "System.Int32") height)))

(cl:defun write (value cl:&optional (arg0 cl:nil supplied-arg0) (arg1 cl:nil supplied-arg1) (arg2 cl:nil supplied-arg2))
  "Master wrapper for System.Console.Write overloads. Dispatches at runtime.

Write(Boolean) -> Void
  Summary: Writes the text representation of the specified Boolean value to the standard output stream.
  Parameters:
    - value (System.Boolean): The value to write.

Write(Char) -> Void
  Summary: Writes the specified Unicode character value to the standard output stream.
  Parameters:
    - value (System.Char): The value to write.

Write(Char[]) -> Void
  Summary: Writes the specified array of Unicode characters to the standard output stream.
  Parameters:
    - buffer (System.Char[]): A Unicode character array.

Write(Double) -> Void
  Summary: Writes the text representation of the specified double-precision floating-point value to the standard output stream.
  Parameters:
    - value (System.Double): The value to write.

Write(Decimal) -> Void
  Summary: Writes the text representation of the specified System.Decimal value to the standard output stream.
  Parameters:
    - value (System.Decimal): The value to write.

Write(Single) -> Void
  Summary: Writes the text representation of the specified single-precision floating-point value to the standard output stream.
  Parameters:
    - value (System.Single): The value to write.

Write(Int32) -> Void
  Summary: Writes the text representation of the specified 32-bit signed integer value to the standard output stream.
  Parameters:
    - value (System.Int32): The value to write.

Write(UInt32) -> Void
  Summary: Writes the text representation of the specified 32-bit unsigned integer value to the standard output stream.
  Parameters:
    - value (System.UInt32): The value to write.

Write(Int64) -> Void
  Summary: Writes the text representation of the specified 64-bit signed integer value to the standard output stream.
  Parameters:
    - value (System.Int64): The value to write.

Write(UInt64) -> Void
  Summary: Writes the text representation of the specified 64-bit unsigned integer value to the standard output stream.
  Parameters:
    - value (System.UInt64): The value to write.

Write(Object) -> Void
  Summary: Writes the text representation of the specified object to the standard output stream.
  Parameters:
    - value (System.Object): The value to write, or .

Write(String) -> Void
  Summary: Writes the specified string value to the standard output stream.
  Parameters:
    - value (System.String): The value to write.

Write(Char]) -> Void
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): 

Write(String, Object) -> Void
  Summary: Writes the text representation of the specified object to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): An object to write using format.

Write(String, Object]) -> Void
  Summary: Writes the text representation of the specified span of objects to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg (System.ReadOnlySpan`1[System.Object]): A span of objects to write using format.

Write(String, Object, Object) -> Void
  Summary: Writes the text representation of the specified objects to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to write using format.
    - arg1 (System.Object): The second object to write using format.

Write(Char[], Int32, Int32) -> Void
  Summary: Writes the specified subarray of Unicode characters to the standard output stream.
  Parameters:
    - buffer (System.Char[]): An array of Unicode characters.
    - index (System.Int32): The starting position in buffer.
    - count (System.Int32): The number of characters to write.

Write(String, Object, Object, Object) -> Void
  Summary: Writes the text representation of the specified objects to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to write using format.
    - arg1 (System.Object): The second object to write using format.
    - arg2 (System.Object): The third object to write using format.
"
  (cl:cond
    ((cl:and (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)))
     (dotnet:static <type-str> "Write" value arg0 arg1 arg2))
    ((cl:and (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-arg1 (cl:or (cl:null arg1) (dotnet:object-type arg1)) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value arg0 arg1))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) supplied-arg0 (cl:numberp arg0) supplied-arg1 (cl:numberp arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value arg0 arg1))
    ((cl:and (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value arg0))
    ((cl:and (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value arg0))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:stringp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    ((cl:and (cl:typep value 'cl:boolean) (cl:not supplied-arg0) (cl:not supplied-arg1) (cl:not supplied-arg2))
     (dotnet:static <type-str> "Write" value))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "Write"
                    :supplied-args (cl:append (cl:list :value value) (cl:when supplied-arg0 (cl:list :arg0 arg0)) (cl:when supplied-arg1 (cl:list :arg1 arg1)) (cl:when supplied-arg2 (cl:list :arg2 arg2)))))))

;; Note: System.Console.Write also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   Write(String, params Object[]) -> Void

(cl:defun write-line (cl:&optional (value cl:nil supplied-value) (arg0 cl:nil supplied-arg0) (count cl:nil supplied-count) (arg2 cl:nil supplied-arg2))
  "Master wrapper for System.Console.WriteLine overloads. Dispatches at runtime.

WriteLine() -> Void
  Summary: Writes the current line terminator to the standard output stream.

WriteLine(Boolean) -> Void
  Summary: Writes the text representation of the specified Boolean value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Boolean): The value to write.

WriteLine(Char) -> Void
  Summary: Writes the specified Unicode character, followed by the current line terminator, value to the standard output stream.
  Parameters:
    - value (System.Char): The value to write.

WriteLine(Char[]) -> Void
  Summary: Writes the specified array of Unicode characters, followed by the current line terminator, to the standard output stream.
  Parameters:
    - buffer (System.Char[]): A Unicode character array.

WriteLine(Decimal) -> Void
  Summary: Writes the text representation of the specified System.Decimal value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Decimal): The value to write.

WriteLine(Double) -> Void
  Summary: Writes the text representation of the specified double-precision floating-point value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Double): The value to write.

WriteLine(Single) -> Void
  Summary: Writes the text representation of the specified single-precision floating-point value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Single): The value to write.

WriteLine(Int32) -> Void
  Summary: Writes the text representation of the specified 32-bit signed integer value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Int32): The value to write.

WriteLine(UInt32) -> Void
  Summary: Writes the text representation of the specified 32-bit unsigned integer value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.UInt32): The value to write.

WriteLine(Int64) -> Void
  Summary: Writes the text representation of the specified 64-bit signed integer value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Int64): The value to write.

WriteLine(UInt64) -> Void
  Summary: Writes the text representation of the specified 64-bit unsigned integer value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.UInt64): The value to write.

WriteLine(Object) -> Void
  Summary: Writes the text representation of the specified object, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.Object): The value to write.

WriteLine(String) -> Void
  Summary: Writes the specified string value, followed by the current line terminator, to the standard output stream.
  Parameters:
    - value (System.String): The value to write.

WriteLine(Char]) -> Void
  Parameters:
    - value (System.ReadOnlySpan`1[System.Char]): 

WriteLine(String, Object) -> Void
  Summary: Writes the text representation of the specified object, followed by the current line terminator, to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): An object to write using format.

WriteLine(String, Object]) -> Void
  Summary: Writes the text representation of the specified span of objects, followed by the current line terminator, to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg (System.ReadOnlySpan`1[System.Object]): A span of objects to write using format.

WriteLine(Char[], Int32, Int32) -> Void
  Summary: Writes the specified subarray of Unicode characters, followed by the current line terminator, to the standard output stream.
  Parameters:
    - buffer (System.Char[]): An array of Unicode characters.
    - index (System.Int32): The starting position in buffer.
    - count (System.Int32): The number of characters to write.

WriteLine(String, Object, Object) -> Void
  Summary: Writes the text representation of the specified objects, followed by the current line terminator, to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to write using format.
    - arg1 (System.Object): The second object to write using format.

WriteLine(String, Object, Object, Object) -> Void
  Summary: Writes the text representation of the specified objects, followed by the current line terminator, to the standard output stream using the specified format information.
  Parameters:
    - format (System.String): A composite format string.
    - arg0 (System.Object): The first object to write using format.
    - arg1 (System.Object): The second object to write using format.
    - arg2 (System.Object): The third object to write using format.
"
  (cl:cond
    ((cl:and supplied-value (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-count (cl:or (cl:null count) (dotnet:object-type count)) supplied-arg2 (cl:or (cl:null arg2) (dotnet:object-type arg2)))
     (dotnet:static <type-str> "WriteLine" value arg0 count arg2))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) supplied-arg0 (cl:numberp arg0) supplied-count (cl:numberp count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value arg0 count))
    ((cl:and supplied-value (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) supplied-count (cl:or (cl:null count) (dotnet:object-type count)) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value arg0 count))
    ((cl:and supplied-value (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value arg0))
    ((cl:and supplied-value (cl:stringp value) supplied-arg0 (cl:or (cl:null arg0) (dotnet:object-type arg0)) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value arg0))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:stringp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:numberp value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:typep value 'cl:boolean) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and supplied-value (cl:or (cl:null value) (dotnet:object-type value)) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine" value))
    ((cl:and (cl:not supplied-value) (cl:not supplied-arg0) (cl:not supplied-count) (cl:not supplied-arg2))
     (dotnet:static <type-str> "WriteLine"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-CONSOLE"
                    :class-name <type-str>
                    :method-name "WriteLine"
                    :supplied-args (cl:append (cl:when supplied-value (cl:list :value value)) (cl:when supplied-arg0 (cl:list :arg0 arg0)) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-arg2 (cl:list :arg2 arg2)))))))

;; Note: System.Console.WriteLine also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   WriteLine(String, params Object[]) -> Void

