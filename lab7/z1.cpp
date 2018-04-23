#include <stdio.h>
#include <string.h>
#include <lua.hpp>
#include <iostream>

using namespace std;
static void stackDump(lua_State *L)
{
    int top = lua_gettop(L);
    cout << "\n<--------- Stos Lua --------->\n";
    for (int i = top; i > 0; i--) // odwiedzamy elementy od dołu
    {
        int t = lua_type(L, i);
        cout << "index: " << i << ", type: " << lua_typename(L, t) << ", value: ";
        switch (t)
        {
        case LUA_TSTRING: // napis
            cout << lua_tostring(L, i);
            break;
        case LUA_TBOOLEAN: // wartość logiczna
            cout << (lua_toboolean(L, i) ? "true" : "false");
            break;
        case LUA_TNUMBER:            // liczby
            cout << lua_tonumber(L, i) << '\n';
            break;
        default:                              // pozostałe
            cout << lua_typename(L, t); // drukuje nazwę typu
            break;
        }
        cout << "\n"; // separator
    }
    cout << "<------- Koniec stosu ------->\n";
    
}

int main(void)
{
    lua_State *L = luaL_newstate();
    lua_pushnumber(L, 3.5);
    stackDump(L);

    lua_pushstring(L, "hello");
    stackDump(L);

    lua_pushnil(L);
    stackDump(L);

    lua_pushvalue(L, -2);
    stackDump(L);

    lua_remove(L, 1);
    stackDump(L);

    lua_insert(L, -2);
    stackDump(L);

    lua_close(L);

    return 0;
}