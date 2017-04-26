import { Room } from './room';

// MessageEntity {
//     id (integer, optional): メッセージID ,
//     content (string, optional): 発言内容 ,
//     published_at (string, optional): 発言日時 ,
//     room (inline_model, optional): 発言があったルーム ,
//     profile (inline_model_0, optional): 発言者情報
// }
// inline_model {
//     id (integer, optional): レコードID ,
//     screen_name (string, optional): ルームID
// }
// inline_model_0 {
//     type (string, optional): 発言者の種類（user|bot） ,
//     screen_name (string, optional): 発言者のスクリーンネーム ,
//     display_name (string, optional): 発言者の表示名 ,
//     avatar (string, optional): 発言時のアバターURL
// }
export interface Message {
    id: number;
    content: string;
    publishedAt: string;
    room: Room;
    profile: Profile;
}

export interface Profile {
    type: string;
    screenName: string;
    displayName: string;
    avatar: string;
}
