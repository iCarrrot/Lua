#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <lua.hpp>

using namespace std;

void error(lua_State *L, const char *fmt, ...)
{
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(1);
}
typedef struct conf
{
    const char* verbose_level;
    bool developer_debug_on;
    int window_height;
    double window_ratio;

    int var5;
    double var6;
    const char* var7;
    bool var8;
    bool var9;
    const char* var10;
} conf;

// zwracamy wartość typu int zapisaną w globalnej zmiennej varname
int getglobalint(lua_State *L, const char *varname)
{
    int isnum, result;

    lua_getglobal(L, varname);                   // wstawiamy zmienną globalną varname na stos
    result = (int)lua_tointegerx(L, -1, &isnum); // odczytujemy ze stosu jej wartość

    if (!isnum) // sprawdzamy czy się poprawnie wczytała
        error(L, "'%s' should be an integer\n", varname);

    lua_pop(L, 1); // usuwamy wczytaną wartość ze stosu
    return result;
}

// zwracamy wartość typu double zapisaną w globalnej zmiennej varname
double getglobaldouble(lua_State *L, const char *varname)
{
    int isnum;
    double result;

    lua_getglobal(L, varname);                     // wstawiamy zmienną globalną varname na stos
    result = (double)lua_tonumberx(L, -1, &isnum); // odczytujemy ze stosu jej wartość

    if (!isnum) // sprawdzamy czy się poprawnie wczytała
        error(L, "'%s' should be a double\n", varname);

    lua_pop(L, 1); // usuwamy wczytaną wartość ze stosu
    return result;
}

// zwracamy wartość typu bool zapisaną w globalnej zmiennej varname
bool getglobalbool(lua_State *L, const char *varname)
{
    bool result;

    lua_getglobal(L, varname);           // wstawiamy zmienną globalną varname na stos
    result = (bool)lua_toboolean(L, -1); // odczytujemy ze stosu jej wartość

    lua_pop(L, 1); // usuwamy wczytaną wartość ze stosu
    return result;
}

// zwracamy wartość typu string zapisaną w globalnej zmiennej varname
const char *getglobalstring(lua_State *L, const char *varname)
{
    const char *result;

    lua_getglobal(L, varname);    // wstawiamy zmienną globalną varname na stos
    result = lua_tostring(L, -1); // odczytujemy ze stosu jej wartość

    lua_pop(L, 1); // usuwamy wczytaną wartość ze stosu
    return result;
}

void load_cfg(lua_State *L, const char *fname, conf *config)
{
    if (luaL_loadfile(L, fname) || lua_pcall(L, 0, 0, 0))
        error(L, "cannot load config file: %s\n", lua_tostring(L, -1));

    config->verbose_level = getglobalstring(L,"verbose_level");
    config->developer_debug_on = getglobalbool(L,"developer_debug_on");
    config->window_height = getglobalint(L,"window_height");
    config->window_ratio = getglobaldouble(L,"window_ratio");

    config->var5 = getglobalint(L,"var5");
    config->var6 = getglobaldouble(L,"var6");
    config->var7 = getglobalstring(L,"var7");
    config->var8 = getglobalbool(L,"var8");
    config->var9 = getglobalbool(L,"var9");
    config->var10 = getglobalstring(L,"var10");
}

int main(void)
{
    lua_State *L = luaL_newstate();

    lua_pushinteger(L, 10);
    lua_setglobal(L, "verbose");

    conf config;

    load_cfg(L, "config.lua", &config);
    cout << "> config file loaded" << endl;
    cout<<config.verbose_level<<" ";
    cout<<config.developer_debug_on<<" ";
    cout<<config.window_height<<" ";
    cout<<config.window_ratio<<" ";

    cout<<config.var5<<" ";
    cout<<config.var6<<" ";
    cout<<config.var7<<" ";
    cout<<config.var8<<" ";
    cout<<config.var9<<" ";
    cout<<config.var10<<" \n";

    lua_pushnumber(L,config.window_height*config.window_ratio);
    lua_setglobal(L, "window_width");
    double w_w = getglobaldouble(L,"window_width");
    cout << w_w <<"\nwinno być: "<<500*0.75<<"\n";

    lua_close(L);

    return 0;
}