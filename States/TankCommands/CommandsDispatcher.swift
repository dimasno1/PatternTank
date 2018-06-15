
import Foundation

protocol Command {
    typealias Completion = () -> Void
    func execute(then completion: Completion?)
}

extension Command {
    func execute() {
        execute(then: nil)
    }
}

final class CommandsDispatcher {
    
    func add(_ command: Command) {
        commandsQueue.append(command)
        executeNext()
    }
    
    func executeNext() {
        guard !isBusy, let command = commandsQueue.first else {
            return
        }
        
        isBusy = true
        commandsQueue.remove(at: 0)
        command.execute { [weak self] in
            self?.isBusy = false
            self?.executeNext()
        }
    }
    
    private(set) var isBusy: Bool = false
    private var commandsQueue: [Command] = []
}
