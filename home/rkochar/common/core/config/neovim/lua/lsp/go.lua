vim.lsp.config("gopls", {
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
            analyses = {
                unusedfunc = true,
                unusedparams = true,
                unusedresult = true,
                unusedvariable = true,
                unusedwrite = true,
                appendclipped = true,
                fieldalignment = true,
                slicesdelete = true,

                QF1006 = true,  -- Lift if+break into for
                QF1007 = true,  -- merge conditional assignment into variable declaration
                QF1001 = true,  -- apply De Morgan's law

                S1002 = true,   -- comparing with bool
                S1005 = true,   -- unnecessary blank identifiers
                S1006 = true,   -- use for in infinite loops
                S1008 = true,   -- simple bool return
                S1011 = true,   -- single append to concatenate two slices
                S1016 = true,   -- auto type convert
                S1021 = true,   -- merge variable declaration and assignment
                S1025 = true,   -- unnecessary fmt.Sprintf("%s", x)
                S1029 = true,   -- range over string directly
                SA1000 = true,  -- invalid regex
                -- SA1002 = true,  -- invalid format in time.Parse
                -- SA1003 = true,  -- unsupported arguements in encoding
                -- SA1007 = true,  -- invalid url net/url.Parse
                SA1014 = true,  -- nom-pointer passed to Unmarshal or Decode
                SA1015 = true,  -- prevent memleak in time.Tick
                SA1017 = true,  -- buffer notify
                SA1023 = true,  -- modify buffer in io.Writer
                SA1024 = true,  -- duplicate characters in string cutset
                SA1025 = true,  -- time.Reset return value
                SA1026 = true,  -- marshal channel/functions
                SA1027 = true,  -- atomic access should be bit aligned
                SA1028 = true,  -- sort.Slice is for slices
                -- SA1029 = true,  -- inappropriate key in call to context.WithValue
                SA1030 = true,  -- strconv
                SA1031 = true,  -- overlapping byte slices in encoder
                SA2003 = true,  -- defer lock after locking
                SA4006 = true,  -- dead value assignment
                SA4008 = true,  -- infinite loop
                SA4009 = true,  -- function arguement is overwritten before being used
                SA4010 = true,  -- dead append
                SA4012 = true,  -- compating with NaN
                SA4017 = true,  -- pointless function calls
                SA4018 = true,  -- self-assignment
                SA4023 = true,  -- impossible comparision of interface
                SA4031 = true,  -- checking never-nil with nil
                SA5000 = true,  -- assignment to nil map
                SA5002 = true,  -- empty for loop
                SA5005 = true,  -- finalizer preventing garbage collection
                SA5007 = true,  -- infinite recursion
                SA6000 = true,  -- regex.Match in a loop. use regex.Compile
                SA6001 = true,  -- optimize indexing maps
                SA6002 = true,  -- storing non-pointers in sync.Pool (extra gc)
                SA6003 = true,  -- unneccessary string to rune conversion
                SA9007 = true,  -- prevent deleting system directories
                SA9008 = true,  -- incorrect type assert in if-else
                ST1003 = true,  -- keyword variable names
                ST1005 = true,  -- incorrectly formatted error strings
                ST1008 = true,  -- function's error value should be last return
                ST1017 = true,  -- YODA conditions
                ST1019 = true,  -- importing the same package multiple times

            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
                parameterNames = true,
                ignoredError = true,
                rangeVariableTypes = true,
            },
        },
    },
})

vim.lsp.enable("gopls")
