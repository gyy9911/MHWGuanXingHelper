# MHWGuanXingHelper 怪物猎人世界观星助手
 ios开发大作业
## 简介
　　在游戏《怪物猎人世界》中，存在这“炼金”这一抽奖机制，每次炼金会随机得到三颗珠子。但炼金结果其实是伪随机的，即读取原来的存档后，再次炼金结果仍是不变的  
　　此外，通过完成任务可以使炼金结果向后跳过，这样可以跳过不想要的结果。完成任务时，炼金结果会以1、1、2的规律向后跳过（即第一、二次跳过一组，第三次跳过两组）  
　　通过大量次数的炼金然后读档，可以得到未来会遇到的结果队列，这种“预知未来”的方法被玩家称为观星；通过任务来跳过不想要的结果，就能只得到想要的结果，以此可以节约炼金所需的成本  
（示例：经过三次炼金后得到了ABC、DEF、GHI这三组珠子，但玩家只想要G这一颗珠子，于是他首先读档回到炼金前，通过一次任务跳过了第一组结果，接着炼金两次得到DEF、GHI两组珠子）  
## 需求  
　　“观星”会得到大量的炼金结果，这些结果通常由玩家手写或使用excel记录，费时费力  
  　　由于跳过的进度不是固定的而是以1、1、2的顺序进行的，需要准确追踪当前进度  
    本app便是为了满足以上需求开发的，可以快速方便地记录每次炼金的结果，并能够追踪记录当前的进度  

    
