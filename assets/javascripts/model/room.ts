// RoomEntity {
//     id (integer, optional): ルームID ,
//     screen_name (string, optional): ルームID ,
//     display_name (string, optional): ルーム名 ,
//     description (string, optional): ルーム説明 ,
//     private (boolean, optional): プライベートルームかどうか ,
// }
export interface Room {
    id: number;
    screenName: string;
    displayName: string;
    description: string;
    private: boolean;
}
