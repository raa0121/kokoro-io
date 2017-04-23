// RoomEntity {
//     id (integer, optional): ルームID ,
//     screen_name (string, optional): ルームID ,
//     display_name (string, optional): ルーム名 ,
//     description (string, optional): ルーム説明 ,
//     private (boolean, optional): プライベートルームかどうか ,
//     publisher_type (string, optional): 発言者の種類 / User or Bot ,
//     published_at (string, optional): 発言日時
// }
export class Room {
    id: number;
    screenName: string;
    displayName: string;
    description: string;
    private: boolean;
    publisherType: string;
    publishedAt: string;
}
