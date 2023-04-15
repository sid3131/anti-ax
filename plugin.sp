#include <sourcemod> 
#include <sdktools> 
#include <scp> 
#include <csgo_colors>

#define PLUGIN_NAME        "Anti DT Fix"
#define PLUGIN_VERSION    "0.0.1"
public Plugin myinfo =
{
    name        = PLUGIN_NAME,
    author        = "Sid",
    version        = PLUGIN_VERSION,
    url            = "spreadhvh:discord.gg/Z67GFxXn"
}

// Register player spawn event hook and command listener
public void OnPluginStart(){
    HookEvent("player_spawn", Event_PlayerSpawned);
    AddCommandListener(OnSWTeam, "jointeam");
}

// Check if client has cl_lagcompensation/cl_predict set to 0
void Check(int client){
    // Skip spectators
    if(GetClientTeam(client) == 0)
        return;

    // Check if m_bLagcompensation is set to 0 and kick if necessary
    if ( GetEntData( client, 0xCD8, 1 ) == 0 ) {
        KickClient(client, "Set cl_lagcompensation to 1");
    }
}

// Handle player spawn event
public Action Event_PlayerSpawned(Event event, const char[] name, bool dontBroadcast)
{    
    int client = GetClientOfUserId(GetEventInt(event, "userid"));
    Check(client);
    return Plugin_Continue; 
}

// Handle join team command
public Action OnSWTeam(int client, const char[] command, int args){
    Check(client);
    return Plugin_Continue; 
}
