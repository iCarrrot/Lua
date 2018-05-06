#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <lua.hpp>

using namespace std;

string board[3][3];

void printBoard()
{
    cout << board[0][0] << "|" << board[0][1] << "|" << board[0][2] << endl;
    cout << "-+-+-\n";
    cout << board[1][0] << "|" << board[1][1] << "|" << board[1][2] << endl;
    cout << "-+-+-\n";
    cout << board[2][0] << "|" << board[2][1] << "|" << board[2][2] << endl
         << endl;
}

int checkWin()
{
    string lines[8] = {
        board[0][0] + board[0][1] + board[0][2],
        board[1][0] + board[1][1] + board[1][2],
        board[2][0] + board[2][1] + board[2][2],

        board[0][0] + board[1][0] + board[2][0],
        board[0][1] + board[1][1] + board[2][1],
        board[0][2] + board[1][2] + board[2][2],

        board[0][0] + board[1][1] + board[2][2],
        board[0][2] + board[1][1] + board[2][0],

    };

    for (int i = 0; i < 8; i++)
    {
        if (lines[i] == "XXX")
            return 1;
        if (lines[i] == "OOO")
            return 2;
    }
    return 0;
}

void putBoard(lua_State *L)
{
    lua_createtable(L, 3, 0);
    for (int i = 0; i < 3; ++i)
    {
        lua_pushnumber(L, i + 1);
        lua_createtable(L, 3, 0);
        for (int j = 0; j < 3; ++j)
        {
            lua_pushnumber(L, j + 1);
            lua_pushstring(L, board[i][j].c_str());
            lua_settable(L, -3);
        }
        lua_settable(L, -3);
    }
}
void error(lua_State *L, const char *fmt, ...)
{
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(1);
}

int main(int argc, char **argv)
{
    char *file0, *file1;
    lua_State *bot1 = luaL_newstate();
    lua_State *bot0 = luaL_newstate();
    luaL_openlibs(bot1);
    luaL_openlibs(bot0);
    if (argc >= 3)
    {
        file1 = argv[1];
        file0 = argv[2];
    }
    else if (argc >= 2)
    {
        file0 = "random.lua";
        file1 = argv[1];
    }
    else
    {
        file0 = "random.lua";
        file1 = "random.lua";
    }

    if (luaL_loadfile(bot1, file1) || lua_pcall(bot1, 0, 0, 0))
        error(bot1, "cannot load config file: %s\n", lua_tostring(bot1, -1));
    if (luaL_loadfile(bot0, file0) || lua_pcall(bot0, 0, 0, 0))
        error(bot0, "cannot load config file: %s\n", lua_tostring(bot0, -1));

    int tries = 10000;
    int w2 =0;
    int cng =0;
    for (int j = 0; j < tries; j++)
    {

    
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 3; j++)
                board[i][j] = " ";
        int end = 0;
        for (int i = cng; i < 9+cng; i++)
        {
            if (i % 2)
            {
                lua_getglobal(bot1, "AI");
                lua_pushstring(bot1, "X");
                putBoard(bot1);
                lua_call(bot1, 2, 2);
                int isnum1, isnum2;
                int x = (int)lua_tointegerx(bot1, -2, &isnum1), y = (int)lua_tointegerx(bot1, -1, &isnum2);
                if (!isnum1 || !isnum2)
                    error(bot1, "Funkcja nie zwróciła 2 liczb całkowitych!");
                lua_pop(bot1, 2);
                if (x < 1 || y < 1 || x > 3 || y > 3)
                {
                    error(bot1, "Zwrócono indeksy spoza tablicy");
                }

                if (board[x - 1][y - 1] == " ")
                {
                    board[x - 1][y - 1] = "X";
                }
                else
                    error(bot1, "Próba zapisania zajętego wcześniej pola");
            }
            else
            {
                lua_getglobal(bot0, "AI");
                lua_pushstring(bot0, "O");
                putBoard(bot0);
                lua_call(bot0, 2, 2);
                int isnum1, isnum2;
                int x = (int)lua_tointegerx(bot0, -2, &isnum1), y = (int)lua_tointegerx(bot0, -1, &isnum2);
                if (!isnum1 || !isnum2)
                    error(bot0, "Funkcja nie zwróciła 2 liczb całkowitych!");
                lua_pop(bot0, 2);
                if (x < 1 || y < 1 || x > 3 || y > 3)
                {
                    error(bot0, "Zwrócono indeksy spoza tablicy");
                }

                if (board[x - 1][y - 1] == " ")
                {
                    board[x - 1][y - 1] = "O";
                }
                else
                    error(bot0, "Próba zapisania zajętego wcześniej pola");
            }
            // printBoard();
            end = checkWin();
            if (end)
            {
                break;
            }
        }
        if (end)
        {
            cout << "wygrał gracz " << (2-end)<< endl;
            2-end ? w2+=1:0;
        }
        else
        {
            cout << "remis" << endl;
        }
        cng+=1;
        cng%=2;
    }
    cout<<"mybot wygral w "<<100*w2/tries<<"% sytuacji"<<endl;
    lua_close(bot1);
    lua_close(bot0);
    return 0;
}