--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]
para_disp = {
    click_function = "empty_func",
    function_owner = self,
    label          = "0",
    position       = {0, 1, 0},
    rotation       = {0, 180, 0},
    width          = 800,
    height         = 400,
    font_size      = 340,
    color          = {0.5, 0.5, 0.5},
    font_color     = {1, 1, 1},
}

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
    params = {
        click_function = "get_card",
        function_owner = self,
        label          = "初始发牌",
        position       = {0, 1, 0},
        rotation       = {0, 180, 0},
        width          = 800,
        height         = 400,
        font_size      = 340,
        color          = {0.5, 0.5, 0.5},
        font_color     = {1, 1, 1},
        tooltip        = "点击按钮为每位玩家发五张牌",
    }
    sq = getObjectFromGUID('8d2b34')
    sq.createButton(params)

    disp = getObjectFromGUID('4d2f14')
    disp.createButton(para_disp)
    print('NBNBNB')
end

function get_card(obj, color, alt_click)
    if alt_click then
        return
    end
    local deck = getObjectFromGUID('319420')
    local cards = deck.getObjects()
    local players = getSeatedPlayers()
    for i, player in ipairs(players) do
        for j = 1, 5 do
            local card = cards[1]
            deck.takeObject({
                position = {0, 0, 0},
                rotation = {0, 180, 0},
                smooth   = false,
                index    = 0,
                callback_function = function(obj)
                    obj.deal(1, player)
                end
            })
        end
    end
end

--[[ 实时显示每位玩家的手牌数 --]]
function show_hand()
    local players = Player.getPlayers()
    for i, player in ipairs(players) do
        print(player)
        local hand = player.getHandObjects()
        local hand_num = #hand
        print(hand_num)
        local hand_num_obj = getObjectFromGUID('4d2f14')
        hand_num_obj.editButton({
            index = i - 1,
            label = hand_num,
        })
    end
end


--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    --[[ print('onUpdate loop!') --]]
    -- show_hand()
end

function empty_func()
end

