import UIKit

class CircularProgressView: UIView {
    
    var percentage: CGFloat = 0.75 // El valor del porcentaje (0.75 representa el 75%)
    
    override func draw(_ rect: CGRect) {
        let lineWidth: CGFloat = 10.0
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * percentage
        
        // Fondo del círculo
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle + 2 * CGFloat.pi, clockwise: true)
        backgroundPath.lineWidth = lineWidth
        UIColor.lightGray.setStroke() // Color del fondo
        backgroundPath.stroke()
        
        // Círculo de progreso
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressPath.lineWidth = lineWidth
        UIColor.systemBlue.setStroke() // Color del gráfico
        progressPath.stroke()
    }
}
