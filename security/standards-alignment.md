# Security Standards Alignment

**Content type:** Informative standards mapping

## Purpose

The WSP Security/DFS profile draws on complementary lifecycle and security
standards. This mapping explains their relationship without reproducing their
controlled text or asserting conformity.

## Primary References

### IEC 62443-4-1:2018

IEC 62443-4-1 defines secure product-development lifecycle requirements for
products intended for industrial automation and control systems (IACS). Its
scope covers security requirements, secure design and implementation,
verification and validation, security-defect handling, update management, and
end-of-life activities.

This is the primary DFS reference for an adopting project that develops or
maintains an IACS product. Projects outside IACS may use its lifecycle concepts
as guidance but shall not imply IEC 62443 conformity from WSP adoption.

### ISO/IEC 27034-1:2011

ISO/IEC 27034-1 introduces application-security concepts and processes for
applications developed internally, acquired, outsourced, or operated by a
third party. WSP uses it as broad context for integrating security into
application management when IEC 62443's IACS product scope does not apply.

### ISO/IEC/IEEE 12207:2026

ISO/IEC/IEEE 12207 establishes a general framework for software lifecycle
processes from conception and acquisition through development, operation,
maintenance, support, and retirement. WSP places security activities within
that wider lifecycle rather than treating the DFS as a one-time design record.

### ISO/IEC/IEEE 29119-2:2021 and 29119-4:2021

Part 2 defines generic software-test processes, and Part 4 defines test-design
techniques used within those processes. WSP applies its existing 29119-aligned
test strategy to security requirements, threats, abuse cases, malformed input,
control failures, and recovery behavior.

## WSP Mapping

| WSP concern | Principal relationship |
| --- | --- |
| Security scope and controlled DFS | IEC 62443-4-1; ISO/IEC 27034-1 |
| Trust model, threats, and derived requirements | IEC 62443-4-1 |
| Secure design, implementation, and review | IEC 62443-4-1 |
| Lifecycle integration and retirement | ISO/IEC/IEEE 12207 |
| Security verification | IEC 62443-4-1; ISO/IEC/IEEE 29119-2 |
| Security test-design techniques | ISO/IEC/IEEE 29119-4 |
| Defect and vulnerability response | IEC 62443-4-1 |
| Updates, rollback, and end of support | IEC 62443-4-1; ISO/IEC/IEEE 12207 |

## Conformity Position

WSP is a process baseline, not an authorized copy, certification scheme, or
complete conformity checklist for any referenced standard. A project claiming
conformity shall obtain the applicable standards, determine every relevant
requirement, preserve objective evidence, and use the required assessment or
certification process independently of WSP adoption.

## References

- [IEC 62443-4-1:2018](https://webstore.iec.ch/en/publication/33615)
- [ISO/IEC 27034-1:2011](https://www.iso.org/standard/44378.html)
- [ISO/IEC/IEEE 12207:2026](https://www.iso.org/standard/90219.html)
- [ISO/IEC/IEEE 29119-2:2021](https://www.iso.org/standard/79428.html)
- [ISO/IEC/IEEE 29119-4:2021](https://www.iso.org/standard/79430.html)
