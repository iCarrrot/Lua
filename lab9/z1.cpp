#include <math.h>
#include <lua.hpp>
#include <iostream>
using namespace std;
static void stackDump(lua_State *L, int number)
{
    int top = lua_gettop(L);
    cout << "\n<--------- Stos Lua "<<number<<"  ------->\n";
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


static int summation(lua_State *L)
{
    double res = 0;
    int a = lua_gettop(L);
    for (int i = 1; i <=a ; ++i)
    {
        res += (double)luaL_checknumber(L, -1);
        lua_pop(L,1);
    }
    lua_pushnumber(L, res);
    return 1;
}


static int reduce(lua_State *L) {
    int pozycja = 1;
    lua_len(L, 2);
    
    int rozmiar = (int) lua_tointeger(L, -1);
    lua_pop(L, 1);

    if (lua_gettop(L) == 2) {
        lua_pushnumber(L, pozycja++);
        lua_gettable(L, -2);
    }
    
    for(; pozycja <= rozmiar; ++pozycja){
        lua_pushvalue(L, 1);
        lua_insert(L, -2);
        lua_pushnumber(L, pozycja);
        lua_gettable(L, 2);
        lua_call(L, 2, 1);
    }
    return 1;
}

static int merge(lua_State *L) {
    int liczba_tablic = lua_gettop(L);
    for(int akt_tab = 2; akt_tab <= liczba_tablic; ++akt_tab){
        lua_pushnil(L);
        while(lua_next(L, akt_tab) != 0){
            lua_pushvalue(L, -2);
            lua_pushvalue(L, -2);
            lua_pushvalue(L, -2);        
            lua_gettable(L, 1);        
            if(lua_type(L, -1) == LUA_TNIL) {            
                lua_pop(L, 1);
                lua_settable(L, 1);
            } else lua_pop(L, 1);        
            
            lua_pop(L, 1);
        }
        lua_pop(L, 1);
        lua_pop(L, 1);     
    }
    lua_settop(L, 1);
    return 1;
}


static const struct luaL_Reg mylib[] =
    {
        {"merge", merge},
        {"summation", summation},
        {"reduce", reduce},
        {NULL, NULL} // sentinel
};

extern "C" int luaopen_lab9_lib(lua_State *L) // wystawienie na zewnątrz (z extern C)
{
    luaL_newlib(L, mylib);
    return 1;
}
