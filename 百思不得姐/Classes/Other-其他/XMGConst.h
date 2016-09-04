//
//  XMGConst.h
//  百思不得姐
//
//  Created by 吴国洪 on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    XMGTopicTypeAll = 1,
    XMGTopicTypePicture = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
}XMGTopicType;

/**
 *  精华-所有顶部标题的高度
 */
UIKIT_EXTERN CGFloat const XMGTitlesViewH;
/**
 *  精华-顶部标题的Y
 */
UIKIT_EXTERN CGFloat const XMGTitlesViewY;
/**
 *  精华-cell-间距
 */
UIKIT_EXTERN CGFloat const XMGTopicCellMargin ;
/**
 *  精华-cell-文字内容的Y值
 */
UIKIT_EXTERN CGFloat const XMGTopicCellTextY ;
/**
 *  精华-cell-底部工具条的高度
 */
UIKIT_EXTERN CGFloat const XMGTopicCellBottomBarH ;
/**
 *  精华-cell-图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH ;
/**
 *  精华-cell-图片贴子一旦超过最大高度，就用Break
 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureBreakH ;

/**
 *  XMGUser模型-性别属性值
 */
UIKIT_EXTERN NSString * const XMGUserSexMale;
UIKIT_EXTERN NSString * const XMGUeerSexFemale;
/**
 *  精华-cell-最热评论标题的高度
 */
UIKIT_EXTERN CGFloat const XMGTopicCellTopCmtTitleH;