#include <stdio.h>
#include <string.h>
#include <cstdlib>
//#include <string>
#include <iostream>
#include <lua.hpp>

using namespace std;

// static void stackDump(lua_State *L)
// {
//     int top = lua_gettop(L);
//     cout << "\n<--------- Stos Lua --------->\n";
//     for (int i = top; i > 0; i--) // odwiedzamy elementy od dołu
//     {
//         int t = lua_type(L, i);
//         cout << "index: " << i << ", type: " << lua_typename(L, t) << ", value: ";
//         switch (t)
//         {
//         case LUA_TSTRING: // napis
//             cout << lua_tostring(L, i);
//             break;
//         case LUA_TBOOLEAN: // wartość logiczna
//             cout << (lua_toboolean(L, i) ? "true" : "false");
//             break;
//         case LUA_TNUMBER:            // liczby
//             cout << lua_tonumber(L, i) << '\n';
//             break;
//         default:                              // pozostałe
//             cout << lua_typename(L, t); // drukuje nazwę typu
//             break;
//         }
//         cout << "\n"; // separator
//     }
//     cout << "<------- Koniec stosu ------->\n";
    
// }

void error(lua_State *L, const char *fmt, ...)
{
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(1);
}

// Uruchamiamy zdefiniowana w Lua funkcję 'f'
float getfunctionvalue(lua_State *L, float x)
{
    int isnum;
    float r;
    // wkładamy na stos funkcję i jej argumenty
    lua_getfield(L, -1, "function");
    lua_pushnumber(L, x); // pierwszy argument

    // wywołujemy funkcję (1 argument, 1 rezultat)
    if (lua_pcall(L, 1, 1, 0) != LUA_OK)
        error(L, "error running function 'f': %s", lua_tostring(L, -1));

    // ściągamy wynik ze stosu
    r = lua_tonumberx(L, -1, &isnum);
    if (!isnum)
        error(L, "function 'f' must return a number");
    lua_pop(L, 1); // balansujemy stos zrzucając wynik
    return r;
}

int getminx(lua_State *L)
{
    int result;
    if (lua_getfield(L, -1, "minx") != LUA_TNUMBER)
        error(L, "invalid minx value");
    result = (int)(lua_tonumber(L, -1));
    lua_pop(L, 1);
    return result;
}
int getmaxx(lua_State *L)
{
    int result;
    if (lua_getfield(L, -1, "maxx") != LUA_TNUMBER)
        error(L, "invalid maxx value");
    result = (int)(lua_tonumber(L, -1));
    lua_pop(L, 1);
    return result;
}
float getstep(lua_State *L)
{
    float result;
    
    if (lua_getfield(L, -1, "step") != LUA_TNUMBER){
        // error(L, "!invalid color component '%s'", "step");
        lua_pop(L, 1);
        return 1;
    }
        
    result = (float)(lua_tonumber(L, -1));
    lua_pop(L, 1);
    return result;
}

void printPlot(int *results, int max, int min, int sizex)
{
    int sizey = max - min + 1;
    char plot[sizex][sizey];
    for (int i = 0; i < sizex; i++)
    {
        for (int j = 0; j < sizey; j++)
        {
            plot[i][j] = ' ';
        }
        plot[i][results[i] - min] = '*';
    }

    for (int j = sizey-1; j >=0 ; j--)
    {
        for (int i = 0; i < sizex; i++)
        {
            cout << plot[i][j];
        }
        cout << endl;
    }
}

int main(void)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);
    if (luaL_loadfile(L, "z2.lua") || lua_pcall(L, 0, 0, 0))
        error(L, "cannot load config file: %s\n", lua_tostring(L, -1));

    lua_getglobal(L, "TOPLOT");
    if (!lua_istable(L, -1))
        error(L, "'TOPLOT' is not a table");
    // stackDump(L);
    int maxx = getmaxx(L);
    int minx = getminx(L);
    float step = getstep(L);
    const int size = (maxx - minx) / step + 1;
    int results[size];
    float x = minx;
    int min, max;
    max = INT_MIN;
    min = INT_MAX;
    for (int i = 0; i < size; ++i)
    {
        results[i] = getfunctionvalue(L, x);
        x += step;
        results[i] < min ? min = results[i] : 0;
        results[i] > max ? max = results[i] : 0;
    }
    printPlot(results, max, min, size);
    lua_close(L);
    return 0;
}