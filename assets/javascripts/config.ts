import * as model from './model';

const KeyActiveRoom = 'kokoro.io/active-room';
const KeySoundEnabled = 'kokoro.io/sound-enabled';

export default class Config {
    getActiveRoom(): Promise<model.Room> {
        return new Promise((resolve, reject) => {
            const value = localStorage.getItem(KeyActiveRoom);
            if (!!value) {
                resolve(JSON.parse(value));
            } else {
                resolve(null);
            }
        });
    }

    setActiveRoom(v: model.Room): void {
        localStorage.setItem(KeyActiveRoom, JSON.stringify(v));
    }

    isSoundEnabled(): Promise<boolean> {
        return new Promise((resolve, reject) => {
            const value = localStorage.getItem(KeySoundEnabled);
            if (!!value) {
                resolve(JSON.parse(value));
            } else {
                resolve(true);
            }
        });
    }

    setSoundEnabled(v: boolean): void {
        localStorage.setItem(KeySoundEnabled, JSON.stringify(v));
    }

    updateTitle(count: number): void {
        document.head.querySelector("title").innerHTML = `(${count}) kokoro.io`;
    }
}
