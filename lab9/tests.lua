local l = require "lab9_lib"

function f(x, y)
    return x + 2 * y
end

function printfk(tab)
    function printfk1(tab)
        local str = "{"
        i = 0
        for k, v in pairs(tab) do
            if i > 1 then
                str = str .. ", "
            else
                i = 2
            end

            if type(tab[k]) == "table" then
                str = str .. printfk1(tab[k])
            else
                str = str .. tostring(k) .. ": " .. tostring(v)
            end
        end
        return str .. "}"
    end
    print(printfk1(tab))
end

-- print("summation")
-- print(l.summation(1, 2, 3, 4, 5))

-- print("reduce")
-- print(l.reduce(f, {1, 2, 3, 4, 5}, 0))
-- print(l.reduce(f, {1, 2, 3, 4, 5}))

print "merge"
x = {a="cf"}
res = l.merge(x,{a = "a", d = "ala", e = "aa", f="bb",g="cc"}, {a = "", b = "b"}, {b = "bb"}, {c = "c", d = "3"})

printfk(res)