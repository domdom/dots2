# Detection
# ‾‾‾‾‾‾‾‾‾
hook global BufCreate .*[.](ll|llvm) %{
    set-option buffer filetype llvm
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
hook global WinSetOption filetype=llvm %{
    require-module llvm
    set-option buffer extra_word_chars '!' '$' '%' '.' '@' '_' '#'
}

hook -group llvm-highlight global WinSetOption filetype=llvm %{
    add-highlighter window/llvm ref llvm
    hook -once -always window WinSetOption filetype=.* %{
        remove-highlighter window/llvm
        unset-face global llvmType
        unset-face global llvmStatement
        unset-face global llvmNumber
        unset-face global llvmComment
        unset-face global llvmString
        unset-face global llvmLabel
        unset-face global llvmKeyword
        unset-face global llvmBoolean
        unset-face global llvmFloat
        unset-face global llvmNoName
        unset-face global llvmConstant
        unset-face global llvmSpecialComment
        unset-face global llvmError
        unset-face global llvmIdentifier
    }
}

provide-module llvm %§


# Faces from the llvm syntaxes
# ‾‾‾‾‾‾‾‾‾‾‾‾
set-face global llvmType red
set-face global llvmStatement operator
set-face global llvmNumber value
set-face global llvmComment comment
set-face global llvmString string
set-face global llvmLabel meta
set-face global llvmKeyword keyword
set-face global llvmBoolean value
set-face global llvmFloat value
set-face global llvmNoName red
set-face global llvmConstant value
set-face global llvmSpecialComment comment
set-face global llvmError error
set-face global llvmIdentifier variable

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/llvm regions
add-highlighter shared/llvm/code  default-region group

# Add llvm types
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(void|half|float|double|x86_fp80|fp128|ppc_fp128)\b" 0:llvmType
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(label|metadata|x86_mmx)\b" 0:llvmType
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(type|label|opaque|token)\b" 0:llvmType
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\bi\d+\b" 0:llvmType

# Add llvm keywords
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(acq_rel|acquire|addrspace|alias|align|alignstack|alwaysinline|appending|argmemonly|arm_aapcscc|arm_aapcs_vfpcc|arm_apcscc|asm|atomic|available_externally|blockaddress|builtin|byval|c|catch|caller|cc|ccc|cleanup|coldcc|comdat|common|constant|datalayout|declare|default|define|deplibs|dereferenceable|distinct|dllexport|dllimport|dso_local|dso_preemptable|except|external|externally_initialized|extern_weak|fastcc|tailcc|filter|from|gc|global|hhvmcc|hhvm_ccc|hidden|immarg|initialexec|inlinehint|inreg|inteldialect|intel_ocl_bicc|internal|linkonce|linkonce_odr|localdynamic|localexec|local_unnamed_addr|minsize|module|monotonic|msp430_intrcc|musttail|naked|nest|noalias|nobuiltin|nocapture|noimplicitfloat|noinline|nonlazybind|nonnull|norecurse|noredzone|noreturn|nounwind|optnone|optsize|personality|private|protected|ptx_device|ptx_kernel|readnone|readonly|release|returned|returns_twice|sanitize_address|sanitize_memory|sanitize_thread|section|seq_cst|sideeffect|signext|syncscope|source_filename|speculatable|spir_func|spir_kernel|sret|ssp|sspreq|sspstrong|strictfp|swiftcc|swiftself|tail|target|thread_local|to|triple|unnamed_addr|unordered|uselistorder|uselistorder_bb|uwtable|volatile|weak|weak_odr|within|writeonly|x86_64_sysvcc|win64cc|x86_fastcallcc|x86_stdcallcc|x86_thiscallcc|zeroext)\b" 0:llvmKeyword

# Add llvm statements
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(add|addrspacecast|alloca|and|arcp|ashr|atomicrmw)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(bitcast|br|catchpad|catchswitch|catchret|call|callbr)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(cleanuppad|cleanupret|cmpxchg|eq|exact|extractelement)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(extractvalue|fadd|fast|fcmp|fdiv|fence|fmul|fpext)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(fptosi|fptoui|fptrunc|free|frem|fsub|fneg|getelementptr)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(icmp|inbounds|indirectbr|insertelement|insertvalue)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(inttoptr|invoke|landingpad|load|lshr|malloc|max|min)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(mul|nand|ne|ninf|nnan|nsw|nsz|nuw|oeq|oge|ogt|ole)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(olt|one|or|ord|phi|ptrtoint|resume|ret|sdiv|select)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(sext|sge|sgt|shl|shufflevector|sitofp|sle|slt|srem)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(store|sub|switch|trunc|udiv|ueq|uge|ugt|uitofp|ule|ult)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(umax|umin|une|uno|unreachable|unwind|urem|va_arg)\b" 0:llvmStatement
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(xchg|xor|zext)\b" 0:llvmStatement

add-highlighter shared/llvm/string region '"' '"' fill llvmString

add-highlighter shared/llvm/code/ regex "\b\d+\b" 0:green
add-highlighter shared/llvm/code/ regex "\B[%%#@!]\d+\b" 0:red
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b-?\d+\b" 0:llvmNumber
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b-?\d+\.\d*(e[+-]\d+)?\b" 0:llvmFloat
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b0x[0-9a-fA-F]+\b" 0:llvmFloat
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(true|false)\b" 0:llvmBoolean
add-highlighter shared/llvm/code/ regex "(?<![%%#@!])\b(zeroinitializer|undef|null|none)\b" 0:llvmConstant
add-highlighter shared/llvm/line_comment region ';' '(?=\n)' fill llvmComment

add-highlighter shared/llvm/code/ regex "[-a-zA-Z$._][-a-zA-Z$._0-9]*:" 0:llvmLabel
add-highlighter shared/llvm/code/ regex "[%%@][-a-zA-Z$._][-a-zA-Z$._0-9]*" 0:llvmIdentifier

§
