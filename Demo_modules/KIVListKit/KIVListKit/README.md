
###说明：
- 1 这个库的初衷，是为了更快的搭建list, 也就是能够快速的使用UITableView和UICollectionView
 同事，也为了将controller瘦身，将数据处理提取出来，让datasource和delegate的功能更单一，让list的视图也界面更加独立化。
 - 2 使用block来触发事件
 - 3 支持cell独立刷新
 
 如：让UICollectionView持有数据和datasource
 
问题1：在使用过程中，设想 表格式的列表，【title:value】 这种可以尝试将title先使用item设置好，再用value来更新itemData即可，？？
问题2：多层列表嵌套的情况 怎么回调？
